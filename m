From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] merge: use editor by default in interactive sessions
Date: Mon, 23 Jan 2012 23:27:23 +0100
Message-ID: <4F1DDECB.5080904@alum.mit.edu>
References: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:27:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSMO-0002jM-PR
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab2AWW12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:27:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41144 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab2AWW12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:27:28 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDBAC.dip.t-dialin.net [84.190.219.172])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0NMRN1U016719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 23 Jan 2012 23:27:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vipk26p1b.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189020>

On 01/23/2012 11:18 PM, Junio C Hamano wrote:
> Traditionally, a cleanly resolved merge was committed by "git merge" using
> the auto-generated merge commit log message with invoking the editor.

s/with/without/

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
