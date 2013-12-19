From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 19 Dec 2013 10:43:23 +0100
Message-ID: <52B2BFBB.5090100@alum.mit.edu>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com> <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com> <52B02DFF.5010408@gmail.com> <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com> <20131217145809.GC15010@thyrsus.com> <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com> <20131217184724.GA17709@thyrsus.com> <52B2335D.2030607@alum.mit.edu> <20131219040604.GA7654@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	=?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Dec 19 10:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vta8l-0004lu-5u
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086Ab3LSJna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 04:43:30 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58769 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751196Ab3LSJn1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 04:43:27 -0500
X-AuditID: 12074413-b7fc76d000002aba-4c-52b2bfbe36a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 69.0D.10938.EBFB2B25; Thu, 19 Dec 2013 04:43:26 -0500 (EST)
Received: from [192.168.69.148] (p57A24715.dip0.t-ipconnect.de [87.162.71.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBJ9hNgr012016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Dec 2013 04:43:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131219040604.GA7654@thyrsus.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsUixO6iqLtv/6Yggy/XlS2ubvGx6LrSzWSx
	4uocZot5d3cxWWxcZ+LA6rFz1l12j0svv7N5LPvayeLxeZNcAEsUt01SYklZcGZ6nr5dAnfG
	msZprAXfeCpm7DrN1MC4nquLkZNDQsBEYt7dqewQtpjEhXvr2boYuTiEBC4zStxcuIMFwjnH
	JHFyeSczSBWvgLbE/xfvGUFsFgFViZVbpjKB2GwCuhKLeprBbFGBIIlHhx6yQ9QLSpyc+QRo
	EAeHiICwxLE+NZCZzAJnGCV6F21iA6kRFlCTePZ0FSPEsrksEp0LfoMt4BQwkJhy4TYTSLOE
	gLhET2MQiMksoC6xfp4QSAWzgLzE9rdzmCcwCs5Csm0WQtUsJFULGJlXMcol5pTm6uYmZuYU
	pybrFicn5uWlFuma6+VmluilppRuYoQEu/AOxl0n5Q4xCnAwKvHwrni5MUiINbGsuDL3EKMk
	B5OSKK/x7k1BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4FUFyvCmJlVWpRfkwKWkOFiVxXrUl
	6n5CAumJJanZqakFqUUwWRkODiUJ3p17gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJL
	SzLiQfEbXwyMYJAUD9Deon0ge4sLEnOBohCtpxh1OeZ9+fCNUYglLz8vVUqctwlkhwBIUUZp
	HtwKWGp7xSgO9LEw72aQUTzAtAg36RXQEiagJcZrwZaUJCKkpBoY5fpzvZrCIwKKf76YkTdj
	fubBWZqXc95cWFty+sDZ/pmWMi5Jd5k/njxjIHzjIl/F+0OrdnNNszRkTs+5/nir 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239518>

On 12/19/2013 05:06 AM, Eric S. Raymond wrote:
> Michael Haggerty <mhagger@alum.mit.edu>:
>> If you haven't tried cvs2git yet, please start it up somewhere in the
>> background.  It might take a while but it should have no trouble with
>> your repos, and then you can compare the tools based on experience
>> rather than speculation.
> 
> That would be a good thing.
> 
> Michael, in case you're wondering why I've continued to work on
> cvs-fast-export when cvs2git exists, there are exactly two reasons:
> (a) it's a whole lot faster on repos that aren't large enough to
> demand multipass,

What difference does speed make on little repositories?  They are fast
enough anyway.

If you are worried about the speed of testing and iterating on your
reposurgeon configuration, then just write the output of cvs2svn to a
temporary file and use the temporary file as input to reposurgeon.

> and (b) the single-whole-dumpfile output makes it a
> better reposurgeon front end.

I can't believe you are still hung up on this!  OK, just for you, here
it is: cvs2git-3.0, in gorgeous pipey purity:

    #! /bin/sh
    blobfile=$(mktemp /tmp/myblobs-XXXXXX.out)
    dumpfile=$(mktemp /tmp/mydump-XXXXXX.out)
    cvs2git-2.0 --blobfile="$blobfile" --dumpfile="$dumpfile" "$@" 1>&2 &&
    cat "$blobfile" "$dumpfile"
    rm "$blobfile" "$dumpfile"

I don't think that cvs2git-2.0 outputs any junk to stdout, but just in
case it does I've redirected stdout explicitly to stderr to avoid
commingling it with the output of this script.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
