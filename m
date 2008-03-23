From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 10:15:23 -0700
Message-ID: <7v4pax8iqc.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <2008-03-23-13-00-28+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdTnv-0002CH-8R
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbYCWRPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYCWRPa
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:15:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYCWRPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:15:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AA52927EF;
	Sun, 23 Mar 2008 13:15:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 315E327EC; Sun, 23 Mar 2008 13:15:26 -0400 (EDT)
In-Reply-To: <2008-03-23-13-00-28+trackit+sam@rfc1149.net> (Samuel Tardieu's
 message of "Sun, 23 Mar 2008 13:00:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77927>

Samuel Tardieu <sam@rfc1149.net> writes:

> I don't see your MIME/Content-Type fix in the list (adding the
> required headers even in presence of user headers). Did I overlook
> something?

Do you mean 6bf4f1b (format-patch: generate MIME header as needed even
when there is format.header, 2008-03-14)?
