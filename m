From: greened@obbligato.org
Subject: Re: [BUG?] git-subtree behavior when the -P tree is removed and recreated
Date: Mon, 31 Dec 2012 19:40:09 -0600
Message-ID: <87623h4r5y.fsf@waller.obbligato.org>
References: <CACUV5ofmuUku=byR1_+Cq+g0SdzqZbH1Z1tPfQf4eNABVyYb_Q@mail.gmail.com>
	<CACUV5odffQoCxr=hTuP+S+DU4+6qD7y=YkTCN3iRr7rjar1bLQ@mail.gmail.com>
	<CACUV5ocT56iOS3dZsJ4JLo70o1HJv2TSrvBHE646SyQVmOuYRg@mail.gmail.com>
	<877gozuooz.fsf@pctrast.inf.ethz.ch>
	<CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Tomi Belan <tomi.belan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 02:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpqts-0001Tu-F4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab3AABkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 20:40:49 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48234 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751111Ab3AABkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 20:40:47 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpqxX-0005Mr-QE; Mon, 31 Dec 2012 19:48:04 -0600
In-Reply-To: <CACUV5odJx1+47ggOAppN7whJhLABrRP-3mRWo8adQqbxF4mA5A@mail.gmail.com>
	(Tomi Belan's message of "Wed, 19 Dec 2012 16:40:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Tomi Belan <tomi.belan@gmail.com> writes: > Thanks. Here's
    one more bump. Avery? David? I don't know how this is supposed to work, unfortunately.
    I'm still in the middle of learning the code... [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                     
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212378>

Tomi Belan <tomi.belan@gmail.com> writes:

> Thanks. Here's one more bump. Avery? David?

I don't know how this is supposed to work, unfortunately.  I'm still in
the middle of learning the code...

                       -David
