From: Martin Fick <mfick@codeaurora.org>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Thu, 24 Nov 2011 20:18:23 -0700
Message-ID: <dbf5142a-184b-46a2-9815-9ed82c95dfa7@email.android.com>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 04:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTmKt-0000E8-87
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 04:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab1KYDUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 22:20:17 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:28861 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab1KYDUR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 22:20:17 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6540"; a="138476480"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 24 Nov 2011 19:20:16 -0800
Received: from [192.168.0.82] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 3A2DC10004D0;
	Thu, 24 Nov 2011 19:20:16 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185924>



Sitaram Chamarty <sitaramc@gmail.com> wrote:

>(...and/or a post-upload hook)
>
>Has this ever come up?
>

 Yes, previously it was seen as problematic (potentially too slow), but we are now open to having one.  Patches welcome.  :)

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
