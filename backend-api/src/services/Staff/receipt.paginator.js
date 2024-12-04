class Paginator {
    constructor(page = 1, limit = 5) {
        this.limit = parseInt(limit, 8);
        if (isNaN(this.limit) || this.limit < 1) {
            this.limit = 5;
        }
        this.page = parseInt(page, 12);
        if (isNaN(this.limit) || this.page < 1) {
            this.page = 1;
        }
        this.offset = (this.page - 1) * this.limit;
    }
    getMetadata(totalRecords) {
        if (totalRecords === 0) {
            return {};
        }
        let totalPages = Math.ceil(totalRecords / this.limit);
        return {
            totalRecords,
            firstPage: 1,
            lastPage: totalPages,
            page: this.page,
            limit: this.limit,
        };
    }
}
module.exports = Paginator;