From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 0/7] changes from last version
Date: Tue,  9 Jun 2015 19:56:20 +0200
Message-ID: <1433872587-15515-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 19:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2NlS-0004oA-G2
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 19:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbFIR4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 13:56:38 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33581 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383AbbFIR4g (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 13:56:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 73010281C;
	Tue,  9 Jun 2015 19:56:34 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id smGvGBXsTnTN; Tue,  9 Jun 2015 19:56:34 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 622F1278F;
	Tue,  9 Jun 2015 19:56:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 5619020E2;
	Tue,  9 Jun 2015 19:56:34 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIbD8IG4KZSH; Tue,  9 Jun 2015 19:56:34 +0200 (CEST)
Received: from Groseille.home (AGrenoble-652-1-286-96.w82-122.abo.wanadoo.fr [82.122.169.96])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 54D8220DC;
	Tue,  9 Jun 2015 19:56:33 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271207>

CHANGES (since last submitted version)

1/7 : identical to previous 1/5
2/7 : identical to previous 2/5
3/7 : identical to previous 3/5
4/7 : Modification previously done by 5/5 (refactoring address process)
5/7 : identical modulo a minor change at hunk @@ -1023,8 +1009,13 @@
       in the function process_address_list due to 4/7
6/7 : new commit
7/7 : new commit

CONFLICT (if merging to pu)

There will be a trivial conflict if merging to pu (with 514554cf,
3169e06d and 6be02640 from Eric Sunshine and Allen Hubbe patch series).
Suppressing conflict marks resolve it.
