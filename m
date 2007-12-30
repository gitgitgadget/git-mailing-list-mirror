From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [PATCH] Force new line at end of commit message
Date: Sun, 30 Dec 2007 20:57:49 +0900
Message-ID: <200712301158.lBUBwT3r004608@mi1.bluebottle.com>
References: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 12:59:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8woo-0003Nn-4j
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 12:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbXL3L6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 06:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbXL3L6d
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 06:58:33 -0500
Received: from mi1.bluebottle.com ([206.188.25.14]:40292 "EHLO
	mi1.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbXL3L6b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 06:58:31 -0500
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi1.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBUBwT3r004608
	for <git@vger.kernel.org>; Sun, 30 Dec 2007 03:58:29 -0800
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:date:subject:in-reply-to:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=y+RMslt8nPNx9OYekbDiM2QobSzvuBKC2/9SXpijBaurtwqCFSE/a+IxYS0hjMh0Z
	JGUtaijhh4eGK1BpBftkAKUMq2EniuBkd/fUBc9r495Og5y/imBaN1ePJy2sux1
Received: from nanako3.mail.bluebottle.com ([211.140.192.186])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id lBUBwAsS013248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Dec 2007 03:58:21 -0800
In-Reply-To: <7vprwo8kzd.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <11468a80a4dab5517d161534884aaf68>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69355>

Quoting Junio C Hamano <gitster@pobox.com>:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Not that I care too deeply, but does that not add a newline regardless 
>> whether it is needed or not?
>
> Heh, I can see that you do not care---the original did not even
> add a newline when necessary (and that is why we have this
> thread).  Instead you were adding a newline regardless to the
> end of the first commit, but not doing so for the other ones.

Aren't you being too harsh on Johannes these days?

Everybody knows that you are capable of rewriting that part in Perl or Python yourself to fix the issue.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Get a free email address with REAL anti-spam protection.
http://www.bluebottle.com/tag/1
