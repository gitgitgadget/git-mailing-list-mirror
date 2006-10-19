From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: "stage files" vs "cached files"
Date: Thu, 19 Oct 2006 15:45:25 +0200
Message-ID: <eh7vl2$unr$1@sea.gmane.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Oct 19 17:46:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaa5O-0006nS-OA
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 17:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946133AbWJSPpa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946134AbWJSPpa
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:45:30 -0400
Received: from main.gmane.org ([80.91.229.2]:1505 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1946133AbWJSPp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 11:45:29 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Gaa4s-0006gp-6P
	for git@vger.kernel.org; Thu, 19 Oct 2006 17:45:02 +0200
Received: from 212.11.48.246 ([212.11.48.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 17:45:02 +0200
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 17:45:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29360>

Hi,

after having read tutorial1+2, I thought the following were more or les=
s=20
synonyms: index ~ directory cache ~ staging area

But then I discover that --cache and --staged are two different things,=
=20
notably when using ls-files.

The documentation states indeed:
  "--cached   Show cached files in the output"
  "--stage    Show stage files in the output"

I'm a bit confused. Is maybe a "stage file" entry missing in the glossa=
ry?

TIA for clarification/pointer.
J=E9r=F4me
