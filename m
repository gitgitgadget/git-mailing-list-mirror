From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man
 git-command"
Date: Thu, 03 Jul 2008 00:44:41 -0700
Message-ID: <7vvdzn2yza.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <20080701162358.GA18305@fieldses.org>
 <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
 <200807030806.37771.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:28:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEKA1-0002yW-6m
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbYGCIVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 04:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbYGCIT2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 04:19:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937024AbYGCHpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 03:45:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C7CCCBB1;
	Thu,  3 Jul 2008 03:44:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A920DCB9A; Thu,  3 Jul 2008 03:44:50 -0400 (EDT)
In-Reply-To: <200807030806.37771.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 3 Jul 2008 08:06:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF9C49A2-48D3-11DD-A5D9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87260>

Christian Couder <chriscool@tuxfamily.org> writes:

> Anyway if we want to get there, perhaps we should use "git help svn" above 
> instead of "man git-svn". (Yeah "git help help" might be confusing at 
> first.)

I do not particularly like advocating "git help" too strongly like that.
I prefer to keep the user perception of "git" to be just "one of the
programs, nothing special".

If you want to learn about "cat", you say "man cat".  If you want to learn
about git, you say "man git", and while you *can* say "git help", the
point is you do *not* have to.  You do not have to run "git" to learn
about it.
