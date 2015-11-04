From: Knut Franke <k.franke@science-computing.de>
Subject: [PATCH v4 0/2]
Date: Wed,  4 Nov 2015 10:13:23 +0100
Message-ID: <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Knut Franke <k.franke@science-computing.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 10:23:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtuIH-0003UN-4t
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 10:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbbKDJXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 04:23:40 -0500
Received: from mx1.science-computing.de ([217.243.222.155]:23283 "EHLO
	mx1.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbbKDJXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 04:23:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id AF6AC495C;
	Wed,  4 Nov 2015 10:13:44 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmSxagCUnqm4; Wed,  4 Nov 2015 10:13:44 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 396FC48FD;
	Wed,  4 Nov 2015 10:13:44 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id 17614A7991; Wed,  4 Nov 2015 10:13:43 +0100 (CET)
X-Mailer: git-send-email 2.3.7
In-Reply-To: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280856>

Changes in the fourth iteration:

* update Documentation/technical/api-remote.txt to reflect the addition to
  struct remote

* update documentation of http.proxy in Documentation/config.txt to mention the
  possibility of having git fill in missing proxy password

* fix decl-after-stmt

* generalize env_override helper to var_override

* more coding style corrections
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
