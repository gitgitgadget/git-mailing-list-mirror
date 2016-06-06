From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3] Documentation more consistent
Date: Mon,  6 Jun 2016 12:09:02 +0200
Message-ID: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
References: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
Cc: gitster@pobox.com, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 12:09:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9rTQ-0006Xw-LO
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 12:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbcFFKJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 06:09:28 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:50590 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbcFFKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 06:09:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 71F532587;
	Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jb3voG2OMICV; Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 62F582583;
	Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 580232066;
	Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3V5kvq03UnfY; Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033212.grenet.fr [130.190.33.212])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 3658B2055;
	Mon,  6 Jun 2016 12:09:25 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296493>

Hello,
as `MAN_BOLD_LITERAL` knob is just now turned on by default with 5945717
(Documentation: bold literals in man, 2016-05-31), it is the right time to
make our documentation more consistent.

Changes since v2: prefix the email subject lines with "doc:"
