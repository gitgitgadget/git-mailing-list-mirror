From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Sun, 28 Aug 2011 08:21:17 +0200
Message-ID: <4E59DE5D.60906@alum.mit.edu>
References: <4E587CC0.4090508@alum.mit.edu> <7vippiaduw.fsf@alter.siamese.dyndns.org> <4E595521.7080208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 08:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxYkf-0004q0-Q0
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 08:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab1H1GVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 02:21:38 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39952 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778Ab1H1GVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 02:21:37 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA689.dip.t-dialin.net [84.190.166.137])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7S6LIE1010707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Aug 2011 08:21:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.20) Gecko/20110805 Lightning/1.0b2 Thunderbird/3.1.12
In-Reply-To: <4E595521.7080208@drmicha.warpmail.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180256>

On 08/27/2011 10:35 PM, Michael J Gruber wrote:
> My current setup is:
> 
> A. I put the additional per commit info in notes. "git format-patch
> --notes" takes it from there and adds it where it belongs.
> 
> B. I put series title and cover letter text into a ref note. "git branch
> --notes" displays them as a branch note, and "git format-patch --cover
> --notes" fills in the cover letter for me.

Very cool.  I will check this out.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
