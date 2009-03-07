From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Add "compare with Git Index" action.
Date: Sat, 7 Mar 2009 01:31:47 +0100
Message-ID: <200903070131.48136.robin.rosenberg.lists@dewire.com>
References: <49AD38EE.5090509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfkXG-00065G-Kv
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 01:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbZCGAee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbZCGAee
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 19:34:34 -0500
Received: from mail.dewire.com ([83.140.172.130]:22429 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbZCGAed (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 19:34:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5412C15E0DEF;
	Sat,  7 Mar 2009 01:34:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AamCq7AoGrUo; Sat,  7 Mar 2009 01:34:29 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.13])
	by dewire.com (Postfix) with ESMTP id 7D84B8027E7;
	Sat,  7 Mar 2009 01:34:29 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <49AD38EE.5090509@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112496>

tisdag 03 mars 2009 15:04:30 skrev Yann Simon <yann.simon.fr@gmail.com>:
> In the Compare With... menu, the "Git Index" action opens
> a diff editor that compares the workspace version of a file and its
> index version.
> 
> The local file can be modified and saved.
> 
> The staged version can be modified and saved. This updates the index.
> For this, add methods into GitIndex to allow to specify a content
> different from the file.

Saving the index version does not work here. No effect whatsoever.

-- robin
