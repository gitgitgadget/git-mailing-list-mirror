From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Showing abbreviated commit hash of the versions
 in Compare editor.
Date: Sun, 13 Jan 2008 19:02:00 -0200
Message-ID: <478A7C48.6040501@intelinet.com.br>
References: <200801072315.30122.rogersoares@intelinet.com.br> <200801110046.41786.robin.rosenberg.lists@dewire.com> <47883600.20307@intelinet.com.br> <200801121644.21173.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 22:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE9yH-0007HD-GJ
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 22:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYAMVBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2008 16:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbYAMVBx
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 16:01:53 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1065 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753566AbYAMVBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 16:01:52 -0500
Received: (qmail 30648 invoked by uid 0); 13 Jan 2008 19:03:50 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.166228 secs); 13 Jan 2008 21:03:50 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 13 Jan 2008 21:03:49 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200801121644.21173.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70411>

Hi Robin,

=46or what I've been using it's all working now.
I saw some typos if you want to update them while you're at it:

Activator.java
     * Instatiate an error exception.
     * Log a dbeug message
GitHistoryPage.java
     * @return reformated comment
     * This class extendes the build in history page with Git features,=
 such

[]s,
Roger.

--
Robin Rosenberg escreveu:
> l=F6rdagen den 12 januari 2008 skrev Roger C. Soares:
>  =20
>> Robin Rosenberg escreveu:
>>    =20
>>> I pushed my doc-branch as pu, you can look at it. My intention is t=
ake a look again
>>> and then push it as master if there are no objections. Is it ok and=
 good to flags=20
>>> public stuff without javadoc as an error (tip pu commit)?
>>>  =20
>>>      =20
>> Got some errors, when trying to export to a deployable plugin:
>> "/home/roger/eclipse/workspace/egit/org.spearce.jgit/tst" does not e=
xist!
>>
>> And on "team -> share project... -> Git", it goes to the CVS wizard.
>>    =20
>
> Due to my lack of testing @_@. I pushed a new pu branch with these tw=
o errors fixed.
>
> Thanks
> -- robin
>
>
>
>  =20
