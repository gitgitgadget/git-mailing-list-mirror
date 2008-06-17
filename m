From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] gitweb: remove unused parse_ref method
Date: Tue, 17 Jun 2008 16:27:08 -0700
Message-ID: <7v7icn4p83.fsf@gitster.siamese.dyndns.org>
References: <1213683928-15128-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 01:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8kb1-0002Cr-4M
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 01:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759713AbYFQX1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 19:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759371AbYFQX1T
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 19:27:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758952AbYFQX1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 19:27:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C75511C72;
	Tue, 17 Jun 2008 19:27:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 73C7311C71; Tue, 17 Jun 2008 19:27:11 -0400 (EDT)
In-Reply-To: <1213683928-15128-1-git-send-email-LeWiemann@gmail.com> (Lea
 Wiemann's message of "Tue, 17 Jun 2008 08:25:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EBF6A402-3CC4-11DD-8F17-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85343>

Thanks.  It should be safe to have this in 1.5.6.
