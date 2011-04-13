From: Tim Smith <tzs@tzs.net>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 15:56:00 -0700
Message-ID: <14EA3D84-5796-4C1A-9B36-DB262CD15B75@tzs.net>
References: <A2315DA1-780C-4024-B774-9AD5F9AA0DB6@medialab.com> <1302721187.21900.4.camel@drew-northup.unet.maine.edu> <1E5D7DCE-B3B3-4CC7-8F40-4ED48E76907D@gmail.com> <1302722214.22161.5.camel@drew-northup.unet.maine.edu> <86vcyigcqy.fsf@red.stonehenge.com> <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Apr 14 01:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA97c-0004Ro-1J
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 01:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612Ab1DMXEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 19:04:53 -0400
Received: from hmkgw.eacceleration.com ([138.210.79.211]:48789 "EHLO
	hmkgw.eacceleration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367Ab1DMXEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 19:04:53 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Apr 2011 19:04:53 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hmkvm-svcml147.hostmark.eacceleration.com (Postfix) with ESMTP id 69B86281BDA1;
	Wed, 13 Apr 2011 22:56:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
	hmkvm-svcml147.hostmark.eacceleration.com
Received: from hmkgw.eacceleration.com ([127.0.0.1])
	by localhost (hmkvm-svcml147.hostmark.eacceleration.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HGTO-YAgTp4v; Wed, 13 Apr 2011 22:56:00 +0000 (UTC)
Received: from timsmith2.hostmark.eacceleration.com (timsmith2.hostmark.eacceleration.com [10.5.0.77])
	by hmkvm-svcml147.hostmark.eacceleration.com (Postfix) with ESMTP id A72DA281BDA0;
	Wed, 13 Apr 2011 22:56:00 +0000 (UTC)
In-Reply-To: <1302725089.22408.11.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171498>


On Apr 13, 2011, at 1:04 PM, Drew Northup wrote:
> On Wed, 2011-04-13 at 12:41 -0700, Randal L. Schwartz wrote:
>> He's made new porcelein, and using the plumbing directly.  That's
>> exactly why we have plumbing in git, right?
> 
> If that's what he's doing then why does he state that the git binaries
> are "for your convenience only"--strongly implying his program will work
> in the absence thereof? I'm hoping he just made a typo--as what he said

Yes, it will work without needing the git binaries he includes. If you already have git binaries (e.g., from macports) you can use those. Hence, the ones he provides are for your convenience, letting you use Gitbox without having to deal with finding and installing git yourself.

-- 
--tzs
