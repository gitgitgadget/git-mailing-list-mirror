From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 0/7] refs backend preamble
Date: Mon, 29 Jun 2015 16:17:49 -0400
Message-ID: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 22:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fVt-0006WH-3s
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbbF2USk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:18:40 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36290 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbF2USk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:18:40 -0400
Received: by qgeg89 with SMTP id g89so5820681qge.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=aI8Yf+m74MX/SymRHWt77Cn70IFBwcuK0NzanHn7Cf8=;
        b=SM1lbrXZivwPGmwlJq6DPndbFx7f3wfTHRFAJiJnPIsF+y/KSj0A2AEZj3yY/kS6TV
         G2iI/ffqc486JqPpAFbovxzMP4+kBbO5ve2iABnCIIobf0jxPxx/RoYmoqsxGyT/YeK+
         1uF2VdPPKpmboZyasukR92R+ADGDA+d4najYWBEWSQQo3xXGJVgRv9tQXoAdEQqKTRbe
         PnXNzrMDLa9vkGSZvQtTGJ7LHr4jk135F44wWjGcWNTs8KxWIUdAERguIeFFVxV1qvlE
         y5o4o0cmK/p2ZO8JiIq99Epu4rKim9mJFogle2VJ+HE8JIyC84rPA2iFJ5F/UPhH4kLC
         pD0g==
X-Gm-Message-State: ALoCoQmfWSBxD0zRGzDCRXsWeZMxXRNmno0nDPbdy0FKGbDK8pA6kVzR1wnMAxuWsXQ9liptn0Bx
X-Received: by 10.140.148.135 with SMTP id 129mr22879960qhu.24.1435609119570;
        Mon, 29 Jun 2015 13:18:39 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 139sm11906090qhx.22.2015.06.29.13.18.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 13:18:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273002>

Minor formatting fixes from Junio Hamano.
