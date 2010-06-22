From: Gavin Kistner <gkistner@nvidia.com>
Subject: Re: unpacker error on push
Date: Tue, 22 Jun 2010 07:04:56 -0700
Message-ID: <BBFECB82-E362-4AB7-86E6-56188BF35611@nvidia.com>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
 <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
 <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
 <26F05D1B-E6A7-4039-B337-DA5C027A4EE5@nvidia.com>
 <alpine.LFD.2.00.1006212054110.24097@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 16:05:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR46F-0007yw-KV
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 16:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758541Ab0FVOFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 10:05:04 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:15424 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932Ab0FVOFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jun 2010 10:05:01 -0400
Received: from hqnvupgp04.nvidia.com (Not Verified[172.20.161.48]) by hqemgate04.nvidia.com
	id <B4c20c2760001>; Tue, 22 Jun 2010 07:02:30 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp04.nvidia.com (PGP Universal service);
  Tue, 22 Jun 2010 07:04:58 -0700
X-PGP-Universal: processed;
	by hqnvupgp04.nvidia.com on Tue, 22 Jun 2010 07:04:58 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.12]) by hqemhub02.nvidia.com
 ([172.17.98.27]) with mapi; Tue, 22 Jun 2010 07:04:58 -0700
Thread-Topic: unpacker error on push
Thread-Index: AcsSE+fW7uLXrroYRz+PcC2ui0rtyw==
In-Reply-To: <alpine.LFD.2.00.1006212054110.24097@xanadu.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149481>

On Jun 21, 2010, at 6:58 PM, Nicolas Pitre wrote:
> Well... I just can't reproduce the issue with those repositories you 
> provided me with.  Neither over git:// nor file:// nor ssh://.  But all 
> I have here are Linux machines, no OSX.
> 
> Could you try pushing from a Linux machine by chance?  Maybe this is an 
> OSX related issue.

I don't have a second linux box to test with, unfortunately.

I will say that I experienced the same problem with a Windows box trying to push to the same repository over git://, and had to switch it to ssh also.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
