From: Henk <henk_westhuis@hotmail.com>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Thu, 18 Dec 2008 00:09:09 -0800 (PST)
Message-ID: <1229587749729-1672012.post@n2.nabble.com>
References: <1229540813648-1669264.post@n2.nabble.com> <c115fd3c0812171204ve560583w4c76aac0ac08d8ae@mail.gmail.com> <1976ea660812171757s37e8435cxc4d34ade04635b81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 09:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDDxq-0003ov-8b
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYLRIJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbYLRIJM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:09:12 -0500
Received: from kuber.nabble.com ([216.139.236.158]:54036 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYLRIJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:09:11 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LDDwT-0001UV-Nl
	for git@vger.kernel.org; Thu, 18 Dec 2008 00:09:09 -0800
In-Reply-To: <1976ea660812171757s37e8435cxc4d34ade04635b81@mail.gmail.com>
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103444>


If you have problems during development, please ask, I might allready
encountered some. Especially when you are starting on the features that need
userinteraction like push/pull/clone/mergetool. These cannot just be run as
a command and catching the standard output. In the version of GitExtensions
I published I just run the commands, but I allready have a prototype build
in c# combined with some c++ that directly calls some (exported) Git
functions. Just executing git.exe is the fastest way of creating a gui, but
its not the best way of doiing things.


Li Frank wrote:
> 
> Great Work!
> TortoiseGit start late. But it reuse many TortoiseSVN work.
> I  believe TortoiseGit can catch.
> 

-- 
View this message in context: http://n2.nabble.com/Announcement%3A-Git-Extensions-stable-%28windows-shell-extensions%29-tp1669264p1672012.html
Sent from the git mailing list archive at Nabble.com.
