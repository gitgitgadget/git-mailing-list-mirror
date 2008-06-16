From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: reset color before printing newline
Date: Mon, 16 Jun 2008 16:23:12 -0700
Message-ID: <7vprqh7yn3.fsf@gitster.siamese.dyndns.org>
References: <1213653602-31307-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 01:24:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8O3b-00062K-N9
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 01:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbYFPXXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 19:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbYFPXXU
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 19:23:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbYFPXXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 19:23:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C73DDDDF9;
	Mon, 16 Jun 2008 19:23:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2E1E0DDF8; Mon, 16 Jun 2008 19:23:16 -0400 (EDT)
In-Reply-To: <1213653602-31307-1-git-send-email-szeder@ira.uka.de> (SZEDER
 =?utf-8?Q?G=C3=A1bor's?= message of "Tue, 17 Jun 2008 00:00:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 341B7F66-3BFB-11DD-989A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85246>

Thanks; makes sense.
