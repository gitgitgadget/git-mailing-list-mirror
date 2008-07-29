From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is 'git BRANCH'?
Date: Tue, 29 Jul 2008 15:24:36 -0700
Message-ID: <7vej5cba6z.fsf@gitster.siamese.dyndns.org>
References: <g6o4vi$rap$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jurko =?utf-8?Q?Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:25:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxdX-0001MO-VX
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbYG2WYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYG2WYn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:24:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbYG2WYn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 18:24:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 562B8416F2;
	Tue, 29 Jul 2008 18:24:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A5AF9416F1; Tue, 29 Jul 2008 18:24:39 -0400 (EDT)
In-Reply-To: <g6o4vi$rap$1@ger.gmane.org> (Jurko =?utf-8?Q?Gospodneti?=
 =?utf-8?Q?=C4=87's?= message of "Wed, 30 Jul 2008 00:18:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23E581F8-5DBD-11DD-80A4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90693>

Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr> writes:

>   Hi.
>
>   I typed in "git BRANCH" by accident and got the error message:
> "fatal: cannot handle BRANCH internally".
>
>   What does that mean?
>
>   It is different from the usual "git: 'yada-yada' is not a
> git-command. See 'git --help'." message you get when you type in an
> incorrect command name.

Just a guess; your git is installed on a case-challenged filesystem?
