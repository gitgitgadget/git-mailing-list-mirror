From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v2 0/9] remote-hg, remote-bzr fixes
Date: Tue, 12 Nov 2013 14:27:45 -0600
Message-ID: <52828f41a412b_3b98795e788b@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 21:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKfq-0002FV-S9
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab3KLUez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:34:55 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35712 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab3KLUey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:34:54 -0500
Received: by mail-ob0-f173.google.com with SMTP id wm4so6603478obc.32
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 12:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=VgRhSlg6Kb5zd/qwvKCsCY64OG2LH86gu+lYHeYr3JU=;
        b=otqdol8Lg4baY+4ChVgCNDZBdU6wtNSQG230hayNc7swZ/Fif35EIyo1sj9dt5gwsE
         zCTEpbn7zjJHDODs5sPDArja8BanNr/LSpnBjbQWIjhqz7JuaduCUAoLUrMmSYTDBiqC
         9D6YwZNVSdxYzVAGFStWK9pvSHyEikKTuEZangqNOtnnAmUR7dbaxFNfLsTUgiwu5RI/
         lQcL2bdK8lXUHIoGE8rjSf3II6YTwAIDQ9brWqVQrtR2p8S1ALNPOUJYJjoMiB8MDNlX
         0doEFF2X9eG51HnAVQuUQC5uRl0XMAwry0FYd/41ZmG19OQ0nwqK+N+c932iUSJMSLdz
         xydA==
X-Received: by 10.182.39.161 with SMTP id q1mr9318230obk.54.1384288493585;
        Tue, 12 Nov 2013 12:34:53 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm35177854obb.5.2013.11.12.12.34.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 12:34:52 -0800 (PST)
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237734>

Richard Hansen wrote:
> A handful of fixes for the git-remote-hg and git-remote-bzr remote
> helpers and their unit tests.

I'm OK with the whole series.

-- 
Felipe Contreras
