From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Use of uninitialized value in string' line 651 git-send-email
 (from the 'next' branch)
Date: Tue, 18 Mar 2008 23:23:04 -0700
Message-ID: <7vprtr44hj.fsf@gitster.siamese.dyndns.org>
References: <f36b08ee0803180644r23c21a21y9d753492be2189ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc3ve-0004Zq-LZ
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbYCSTZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbYCSTZS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:25:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYCSTZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:25:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39FDC2D7F;
	Wed, 19 Mar 2008 02:23:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B05EC2D7E; Wed, 19 Mar 2008 02:23:14 -0400 (EDT)
In-Reply-To: <f36b08ee0803180644r23c21a21y9d753492be2189ec@mail.gmail.com>
 (Yakov Lerner's message of "Tue, 18 Mar 2008 15:44:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77503>

Does it happen with "master" as well?
