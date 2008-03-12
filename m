From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] add test_cmp function for test scripts
Date: Wed, 12 Mar 2008 15:12:45 -0700
Message-ID: <7vmyp34mn6.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213636.GG26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:13:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZZCe-0006eX-L0
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 23:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbYCLWM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 18:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755187AbYCLWM4
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 18:12:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbYCLWMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 18:12:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F0FA42D00;
	Wed, 12 Mar 2008 18:12:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5910E2CF9; Wed, 12 Mar 2008 18:12:48 -0400 (EDT)
In-Reply-To: <20080312213636.GG26286@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Mar 2008 17:36:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77011>

I think I have an earlier round of this in 'pu'.
