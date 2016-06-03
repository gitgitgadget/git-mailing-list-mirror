From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v2] Documentation more consistent
Date: Sat,  4 Jun 2016 00:08:34 +0200
Message-ID: <20160603220837.9842-1-tom.russello@grenoble-inp.org>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
Cc: matthieu.moy@grenoble-inp.fr, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	peff@peff.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 00:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8xK6-0006Ad-4r
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 00:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbcFCWLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 18:11:55 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:35856 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964812AbcFCWLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 18:11:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0D67C20DB;
	Sat,  4 Jun 2016 00:11:49 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0nQLdRnaKW1m; Sat,  4 Jun 2016 00:11:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id E946320D9;
	Sat,  4 Jun 2016 00:11:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id E2D622077;
	Sat,  4 Jun 2016 00:11:48 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xfCFn45Lv8RB; Sat,  4 Jun 2016 00:11:48 +0200 (CEST)
Received: from ux-305.numericable.fr (1.23.6.84.rev.sfr.net [84.6.23.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 9B8802066;
	Sat,  4 Jun 2016 00:11:48 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296418>

Hello,
as `MAN_BOLD_LITERAL` knob is now turned on by default, it is the right time to
make our documentation more consistent.
