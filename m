From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sat, 29 Sep 2007 12:32:27 +0700
Message-ID: <fcaeb9bf0709282232v376d2bccoc7ffcc5ae184b59e@mail.gmail.com>
References: <87ir5us82a.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 07:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbUwM-0002ej-NE
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 07:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbXI2Fc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 01:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXI2Fc3
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 01:32:29 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:9763 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbXI2Fc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 01:32:28 -0400
Received: by nz-out-0506.google.com with SMTP id s18so2173894nze
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 22:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4wMsNJEizCsTdrnpV4WxXHCXuS4VP9aIao08t36S+A8=;
        b=MJxoNe3DVnQJf5HNpkxNFhvGandhaQoMhfqlZeyo2eLE4tWGfKTr2wmHdejqngNCtVn7CKfX5aKyKYws1c2oRpLlL4clLeVdNEyiUp4X3dnlmEwnvOkuhW9D8gK5bWjWH7lwmgGpCuqwxFAHjtJ8aV7vc5UqEPhRTs705ztdIq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FsOoyvI+4FHTqQl9MECQZ25qN0ojMaAeW4zyc01CkgXjCJEjOmZi8yDStlq3v99OGi7QSfw1/3Be0CXb+tpD8CH8tSwjdGKMFQPxfMAovacBkn9HpVHF7YEiVQ4ReHnvwB+3R8Q5EDMPPU4vdaF74rGq1LpMrorEQjgB4tGci44=
Received: by 10.115.54.1 with SMTP id g1mr1286650wak.1191043947281;
        Fri, 28 Sep 2007 22:32:27 -0700 (PDT)
Received: by 10.140.131.20 with HTTP; Fri, 28 Sep 2007 22:32:27 -0700 (PDT)
In-Reply-To: <87ir5us82a.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59441>

On 9/29/07, Carl Worth <cworth@cworth.org> wrote:
> I recently "ported" the introductory chapter of Bryan O'Sullivan's
> Distributed revision control with Mercurial[1] from mercurial to
> git. The result is here:
>
>         A tour of git: the basics
>         http://cworth.org/hgbook-git/tour/

Minor thing. On Gentoo you should do "emerge dev-util/git" instead of
"emerge git" because there is another program with the same name.
-- 
Duy
