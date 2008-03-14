From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: help: explain 'man.viewer' multiple values
Date: Thu, 13 Mar 2008 22:14:15 -0700
Message-ID: <7vhcf9ubtk.fsf@gitster.siamese.dyndns.org>
References: <20080313064846.b6b54c11.chriscool@tuxfamily.org>
 <200803140100.m2E107Zl004673@localhost.localdomain>
 <200803140615.25266.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Xavier Maillard <xma@gnu.org>, junkio@cox.net, pascal@obry.net,
	nanako3@bluebottle.com, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 06:15:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja2G6-0005IK-B4
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 06:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbYCNFOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 01:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbYCNFOc
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 01:14:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbYCNFOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 01:14:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C75F013D2;
	Fri, 14 Mar 2008 01:14:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DC17213D1; Fri, 14 Mar 2008 01:14:22 -0400 (EDT)
In-Reply-To: <200803140615.25266.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 14 Mar 2008 06:15:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77181>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le vendredi 14 mars 2008, Xavier Maillard a =C3=A9crit :
>>     man.viewer::
>>    -	Specify the program that will be used to display help in the
>>    +	Specify the programs that may be used to display help in the
>>
>> I would have prefered the following wording:
>>
>> "List of viewer candidates used to display help in"
>>
>>    +If everythings fails the 'man' program will be tried anyway.
>>        ^^^^^^^^^^^
>> everything :)
>
> Thank you Xavier for reviewing and testing my patches.
> But as my patch has already been commited (in next), could you send a=
 patch=20
> on top of it ?

No need, I've locally fixed it up.
