From: Daniel Villeneuve <daniel2villeneuve@videotron.ca>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Mon, 02 Jun 2008 22:16:38 -0400
Message-ID: <4844A986.1050209@videotron.ca>
References: <200806030314.03252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 04:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3M5d-00037f-4X
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 04:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbYFCCQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 22:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbYFCCQk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 22:16:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42062 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYFCCQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 22:16:39 -0400
Received: from [192.168.1.100] ([24.203.62.135]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K1V001WU7NQVG11@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 02 Jun 2008 22:16:38 -0400 (EDT)
User-Agent: Thunderbird 1.5.0.12 (X11/20080411)
In-reply-to: <200806030314.03252.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83610>

Jakub Narebski wrote:
> I think that octopus merge (merge with more than two parents/legs) is 
> feature which is unique to git (isn't it?).  
PRCS (http://prcs.sourceforge.net) allows to merge multiple branches 
into the
current working directory, making the eventually committed version have 
multiple
parents.
--
Daniel Villeneuve
