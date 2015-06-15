From: "Simon A. Eugster" <simon.eu@gmail.com>
Subject: [PATCH] Documentation clarification on git-checkout
Date: Mon, 15 Jun 2015 14:47:25 +0200
Message-ID: <1434372447-51230-1-git-send-email-simon.eu@gmail.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 15 14:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4To2-0001vU-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 14:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbbFOMrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 08:47:53 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34871 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453AbbFOMrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 08:47:52 -0400
Received: by wgbhy7 with SMTP id hy7so34719710wgb.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mbVTAaJXXxpgbb/B8Aa5hwPo97+y/hGE3aLWr39UdrA=;
        b=dx9ThiZBCQmjmRT90Ynj4PQ3DTkE6cCyXPxkPzFXgdFPSYVfgU5mJi3V8W/CmnfNKx
         eGk5vKinor9uzVRkz4p0kjuKvOjiisvnTrriV37V8K8dOxyJZvC5lXPYTBF342KvHsZN
         /XvtGazogOoxQeOSTPMaMA1eXl1D87+85RDXxlyx/W5IL3fMf7CAUdgBQRi9YUfihn1J
         qZNGrKwwRQci07DwkyoAatmwybXFUFlPzSesdDFwfxywBboVm2FKf7WtB6Q8fyz59dKn
         krwYTScriZxbzYdJF4Ao2b031MYDMk2JwPhArcD2iG0pmt/Kbbi8eH6bix3rFN/RTsbb
         Z0xw==
X-Received: by 10.194.104.98 with SMTP id gd2mr48942425wjb.35.1434372470783;
        Mon, 15 Jun 2015 05:47:50 -0700 (PDT)
Received: from sie-matemint.localdomain ([194.9.120.21])
        by mx.google.com with ESMTPSA id js3sm18780287wjc.5.2015.06.15.05.47.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2015 05:47:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271680>


I hope I managed to get this working with replying to your response, 
Junio, git send-email is all new to me.

Thanks a lot for your detailled answer. I tried to integrate it and 
hope it is understandable this way? 

Simon
