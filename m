From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] CLI option parsing and usage generation for porcelains
Date: Sat, 13 Oct 2007 16:53:10 +0200
Message-ID: <14AB1C41-E8D6-41E7-AE09-A85589A3FB92@wincent.com>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 16:54:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiNY-0003CI-Ll
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 16:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763053AbXJMOxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Oct 2007 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763147AbXJMOxj
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 10:53:39 -0400
Received: from wincent.com ([72.3.236.74]:46484 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763309AbXJMOxi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Oct 2007 10:53:38 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9DEra61014368;
	Sat, 13 Oct 2007 09:53:37 -0500
In-Reply-To: <1192282153-26684-1-git-send-email-madcoder@debian.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 13/10/2007, a las 15:29, Pierre Habouzit escribi=F3:

>   The following series is open for comments, it's not 100% ready for
> inclusion IMHO, as some details may need to be sorted out first, and
> that I've not re-read the patches thoroughly yet. Though I uses the =20
> tip
> of that branch as my everyday git for 2 weeks or so without any
> noticeable issues.

Great to see two things:

- the simplification in the commands switched over to use the options =20
parser

- the improved readability and usefulness of the options help

Great work, Pierre! I'll take a closer look at this and trial it in =20
my local Git install for a while to see if any issues come up.

Wincent
