From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove redundant code, eliminate one static variable
Date: Sat, 24 May 2008 22:12:26 -0700
Message-ID: <7vhccnj7b9.fsf@gitster.siamese.dyndns.org>
References: <20080523224355.GA16878@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 25 07:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K08Y0-0005LE-I9
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 07:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbYEYFMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 01:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYEYFMh
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 01:12:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbYEYFMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 01:12:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6A964726;
	Sun, 25 May 2008 01:12:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EAA634725; Sun, 25 May 2008 01:12:28 -0400 (EDT)
In-Reply-To: <20080523224355.GA16878@zakalwe.fi> (Heikki Orsila's message of
 "Sat, 24 May 2008 01:43:55 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2EB82590-2A19-11DD-98F8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82850>

Thanks.
