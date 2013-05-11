From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git-svn updates for 1.8.3-rc2
Date: Sat, 11 May 2013 11:09:29 -0700
Message-ID: <7vehddxuau.fsf@alter.siamese.dyndns.org>
References: <20130510202640.GA16349@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Walmsley <pjwhams@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Contreras <michael@inetric.com>,
	Avishay Lavie <avishay.lavie@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat May 11 20:09:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbEEj-0005td-8H
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 20:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab3EKSJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 14:09:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58710 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab3EKSJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 14:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C817F1DB4F;
	Sat, 11 May 2013 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=J9ImHV
	JSQeV3hHDH45ipAEU/EJGZrTbGe2oAGIhxey4Og19figCZOsScC77OCypxIUYkvk
	40rcMM6EzK8YfJwYqOPaG836w+EXtmd/zOB3CJBhWDC8Ce4ufEIku+7/P1g5aZH6
	he3qHkVJ7s/ZuezhDkhOAoiupFr1OXKqlSFOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j51o2tGaOoCBjE0VDdNUBBEunUG1KIpk
	HzEL7pk4W/FbjpUfLxR4wXsgy0xmhY5dL/IVEo+hRyrNzWGlMFp1iSzR+ZHyu7dX
	o+fVSdko6/s8njMzNTP47BbLJcjckIWa9kZKyLDlgrlQTHM/t77x+Q04MYDV96L3
	gl7K2pwt5bQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAB201DB4E;
	Sat, 11 May 2013 18:09:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43FFF1DB4B;
	Sat, 11 May 2013 18:09:31 +0000 (UTC)
In-Reply-To: <20130510202640.GA16349@dcvr.yhbt.net> (Eric Wong's message of
	"Fri, 10 May 2013 20:26:40 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED75979C-BA65-11E2-9FA2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223998>

Thanks, pulled.
