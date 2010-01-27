From: Crane Cai <crane.cai@amd.com>
Subject: Re: 3 question about how to use Git .
Date: Wed, 27 Jan 2010 17:32:25 +0800
Message-ID: <20100127093225.GB3708@crane-desktop>
References: <e78dc7d71001270034k48e1a386p64e01eb8d6d1187a@mail.gmail.com>
 <e78dc7d71001270035p4e235f18o59029b93bea25d4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: git@vger.kernel.org
To: honglei junan <jhonglei@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 10:37:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na4LQ-0005Ny-GN
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 10:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700Ab0A0Jhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 04:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630Ab0A0Jhp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 04:37:45 -0500
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:58280
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753440Ab0A0Jho (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 04:37:44 -0500
Received: from mail134-va3-R.bigfish.com (10.7.14.249) by
 VA3EHSOBE003.bigfish.com (10.7.40.23) with Microsoft SMTP Server id
 8.1.240.5; Wed, 27 Jan 2010 09:37:43 +0000
Received: from mail134-va3 (localhost [127.0.0.1])	by
 mail134-va3-R.bigfish.com (Postfix) with ESMTP id 6408F10788;	Wed, 27 Jan
 2010 09:37:43 +0000 (UTC)
X-SpamScore: 2
X-BigFish: VPS2(z33d9k3b68jz98dNzz1202hzzz32i6bh43j61h)
X-Spam-TCS-SCL: 0:0
Received: from mail134-va3 (localhost.localdomain [127.0.0.1]) by mail134-va3
 (MessageSwitch) id 126458506374935_6861; Wed, 27 Jan 2010 09:37:43 +0000
 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.244])	by
 mail134-va3.bigfish.com (Postfix) with ESMTP id 1F73D6F00E8;	Wed, 27 Jan 2010
 09:36:58 +0000 (UTC)
Received: from svlb1extmailp01.amd.com (139.95.251.8) by
 VA3EHSMHS003.bigfish.com (10.7.99.13) with Microsoft SMTP Server (TLS) id
 14.0.482.39; Wed, 27 Jan 2010 09:36:56 +0000
Received: from svlb1twp02.amd.com ([139.95.250.35])	by svlb1extmailp01.amd.com
 (Switch-3.2.7/Switch-3.2.7) with ESMTP id o0R9c9LN029842;	Wed, 27 Jan 2010
 01:38:12 -0800
X-WSS-ID: 0KWWG1B-04-74S-02
X-M-MSG: 
Received: from SSVLEXBH1.amd.com (ssvlexbh1.amd.com [139.95.53.182])	by
 svlb1twp02.amd.com (Tumbleweed MailGate 3.7.2) with ESMTP id 2CAC71B10352;
	Wed, 27 Jan 2010 01:36:47 -0800 (PST)
Received: from ssvlexmb2.amd.com ([139.95.53.7]) by SSVLEXBH1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27 Jan 2010 01:36:50 -0800
Received: from storexbh1.amd.com ([10.1.1.17]) by ssvlexmb2.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27 Jan 2010 01:36:50 -0800
Received: from sshaexmb1.amd.com ([10.237.2.11]) by storexbh1.amd.com with
 Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27 Jan 2010 04:36:48 -0500
Received: from crane-desktop.amd.com ([10.237.82.14]) by sshaexmb1.amd.com
 with Microsoft SMTPSVC(6.0.3790.3959);	 Wed, 27 Jan 2010 17:36:43 +0800
Received: by crane-desktop.amd.com (sSMTP sendmail emulation); Wed, 27 Jan
 2010 17:32:25 +0800
Mail-Followup-To: Crane Cai <crane.cai@amd.com>,
	honglei junan <jhonglei@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e78dc7d71001270035p4e235f18o59029b93bea25d4e@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 27 Jan 2010 09:36:43.0753 (UTC) FILETIME=[3C9D2D90:01CA9F34]
X-Reverse-DNS: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138121>

On Wed, Jan 27, 2010 at 04:35:53PM +0800, honglei junan wrote:
> hi,i have three questions seem not not appear in GitFaq,yet confuse me much :
> *) since I've already commit many patches before telling git my name
> and email,should i roll back and recommit all patches to make my name
> in repository?
One way I do:
#checkout your commits
git format-patch since-your-commit
#reset head to begin
git reset --hard since-your-commit
#change your commits in patches, then am
git am your-patches
> *) when cloning a git repository,the network is broken down.How could
> i went on the clone process when the network being OK ?
> since the download speed is very low, i really don't want to remove
> all things and download them again.
you need not to remove, just redo clone.

-- 
Best Regards,
- Crane
