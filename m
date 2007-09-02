From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Buffer overflows
Date: Sun, 2 Sep 2007 16:35:32 +0100
Message-ID: <3f4fd2640709020835w4058c55dqb753613bde7aa533@mail.gmail.com>
References: <1188502009.29782.874.camel@hurina>
	 <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
	 <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
	 <200709021542.31100.johan@herland.net>
	 <3f4fd2640709020811r4ea8f01fw775257859e26af29@mail.gmail.com>
	 <85veatqelm.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "David Kastrup" <dak@gnu.org>, "Johan Herland" <johan@herland.net>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds
X-From: git-owner@vger.kernel.org Sun Sep 02 17:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRrU8-0002ew-Pf
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 17:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbXIBPfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 11:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXIBPfd
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 11:35:33 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:62599 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbXIBPfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 11:35:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so755458rvb
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 08:35:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FcpCIIr3ZoTAEL+VC0dk8Dsk12bFMp22Sr1xXvhFmwf84DLpEnpWWq/3cvUzXB5kzSMfHMZovIL4J9qxgeStxu1d3/ioAUGCmWoGFTXi5PiQsxHaEjBS75O+Cx/xrVONwZIMdokZdbPLv59iav390dwQCSOapc8n5VjzOjQopv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ejVjHmKWYq0CaZVtTxHh9DrPTWUeuyW5BCarGVmuCQKP5aHGWvuOZzTy8zBe9N6KL+E4bbVicD9jv7VItvDa3RRFMoPkxEbPXcxVtPLcADRf9wQNX7voAua+xgwf0ttLD2Te5Huvsef5xnLFlZ7IraJM6Iu6Y8ypQGVhdzLkAMo=
Received: by 10.141.76.21 with SMTP id d21mr264048rvl.1188747332075;
        Sun, 02 Sep 2007 08:35:32 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Sun, 2 Sep 2007 08:35:31 -0700 (PDT)
In-Reply-To: <85veatqelm.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57343>

On 02/09/07, David Kastrup <dak@gnu.org> wrote:
> "Reece Dunn" <msclrhd@googlemail.com> writes:
>
> > Which is good, as this means that along with the tests in the
> > library, it will be more stable and less likely to be buggy than
> > something that is written from scratch.
>
> Remember git's history.

True!

- Reece
