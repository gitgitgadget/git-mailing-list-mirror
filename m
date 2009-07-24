From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Eclipse git plugin help -- diffs
Date: Fri, 24 Jul 2009 22:51:27 +0200
Message-ID: <200907242251.28330.robin.rosenberg.lists@dewire.com>
References: <4A6A153E.9020508@ntung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicholas Tung <ntung@ntung.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 22:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MURk1-0000vP-H8
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbZGXUvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 16:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbZGXUvf
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 16:51:35 -0400
Received: from mail.dewire.com ([83.140.172.130]:8690 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZGXUve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 16:51:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 046791481DBF;
	Fri, 24 Jul 2009 22:51:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id br784K9Nom2L; Fri, 24 Jul 2009 22:51:29 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 7CFA41481DBD;
	Fri, 24 Jul 2009 22:51:29 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4A6A153E.9020508@ntung.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123945>

fredag 24 juli 2009 22:10:38 skrev Nicholas Tung <ntung@ntung.com>:
> Hi all,
> 
>     I can't find the "quick diff" feature listed on the Eclipse git
> website. I'm using version 0.5 (should be the latest). The history graph
> and diffs for changes /_already committed_/ are very nice. I seem to be
> able to execute a "diff from index" on a per-file basis; I'd like to see
> changes made to all files (what's going to be committed), and possibly
> diff with HEAD instead of the index.

Enable it in Workspace/Preferences (search for quickdiff) by selecting "A Git Revision".
(If an editor is open you have to reopen that editor to see the diff immediatley).

-- robin
