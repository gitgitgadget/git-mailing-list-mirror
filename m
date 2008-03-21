From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend 2/2] Don't try and percent-escape existing percent
 escapes in git-svn URIs
Date: Thu, 20 Mar 2008 23:52:55 -0700
Message-ID: <7vtzj0r2k8.fsf@gitster.siamese.dyndns.org>
References: <1206043729-61810-1-git-send-email-kevin@sb.org>
 <1206043729-61810-2-git-send-email-kevin@sb.org>
 <20080321065130.GA28144@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 07:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcb8M-0007OS-3D
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 07:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbYCUGxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 02:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYCUGxF
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 02:53:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429AbYCUGxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 02:53:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 09BA92C65;
	Fri, 21 Mar 2008 02:53:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7268F2C63; Fri, 21 Mar 2008 02:52:58 -0400 (EDT)
In-Reply-To: <20080321065130.GA28144@muzzle> (Eric Wong's message of "Thu, 20
 Mar 2008 23:51:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77723>

Thanks.
