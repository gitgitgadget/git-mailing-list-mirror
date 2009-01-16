From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit  state
Date: Fri, 16 Jan 2009 11:58:06 +0100
Message-ID: <200901161158.06828.johan@herland.net>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <200901161050.13971.johan@herland.net> <49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jay Soffian" <jaysoffian@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Sverre Rabbelier" <srabbelier@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:00:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNmQb-0004cK-OA
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 11:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbZAPK63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 05:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756903AbZAPK62
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 05:58:28 -0500
Received: from sam.opera.com ([213.236.208.81]:58738 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbZAPK62 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 05:58:28 -0500
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n0GAw74R028859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 16 Jan 2009 10:58:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105936>

On Friday 16 January 2009, Anders Melchiorsen wrote:
> Johan Herland wrote:
> > 	amend e8902c1 Foo
> >
> > does a "pick" followed by "commit --amend" (for editing the commit
> > message), followed by "rebase --continue".
>
> I do not think that "amend" is the best word for editing only the
> commit message. A "commit --amend" can also make a new tree, so
> reusing the word with a different meaning could be bad.
>
> As for alternatives, however, I can only come up with "copyedit", and
> that is so horrible that I will not even propose it :-)

"rephrase"?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
