From: =?UTF-8?q?Philip=20J=C3=A4genstedt?= <philip@foolip.org>
Subject: [PATCH v3] completion: remote set-* <name> and <branch>
Date: Wed, 22 Feb 2012 09:58:09 +0100
Message-ID: <1329901093-24106-1-git-send-email-philip@foolip.org>
References: <20120222001737.GB2228@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 09:58:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0823-00062T-Ur
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 09:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab2BVI6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 03:58:35 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab2BVI6e (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 03:58:34 -0500
Received: by lagu2 with SMTP id u2so8716873lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 00:58:32 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.152.129.137 as permitted sender) client-ip=10.152.129.137;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.152.129.137 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.152.129.137])
        by 10.152.129.137 with SMTP id nw9mr992780lab.48.1329901112975 (num_hops = 1);
        Wed, 22 Feb 2012 00:58:32 -0800 (PST)
Received: by 10.152.129.137 with SMTP id nw9mr842471lab.48.1329901112911;
        Wed, 22 Feb 2012 00:58:32 -0800 (PST)
Received: from localhost.localdomain (h128n3-g-hn-a11.ias.bredband.telia.com. [217.209.32.128])
        by mx.google.com with ESMTPS id ot2sm24473095lab.3.2012.02.22.00.58.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 00:58:32 -0800 (PST)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <20120222001737.GB2228@goldbirke>
X-Gm-Message-State: ALoCoQkQPwHEKPYSp5mrwryQvqXZwzV2Xb7fLJrdYEmx4YlSQoqmRMmxORbaGUXRBmjl0bkoAnQf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191236>

Hope this works better. Is it possible to use format-patch or send-email 
to get subjects like [PATCH 1/4 v3], as opposed to what I am sending?
