From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am.txt: advertise 'git am --abort' instead of 'rm
 .git/rebase-apply'
Date: Tue, 22 Mar 2011 12:11:48 -0700
Message-ID: <7vy647j7gr.fsf@alter.siamese.dyndns.org>
References: <1300819345-28279-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2700-00070u-0N
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab1CVTMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 15:12:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab1CVTMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:12:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34A213251;
	Tue, 22 Mar 2011 15:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SiGKEklEVJKl7ZLyFRV0RcoiLxo=; b=VVJvnb
	Ffu6ZIzrC++aXv4aSolHZwHZRPrzMVW7UKAKRu25wHD6tHTgjjTZ2Y+Q3bc6m1YU
	0ypSZkxtJmfcvn/6Mz2TuHXRE7ySXLdsAeyzAP2S1UbLBdwZ1uK1g4ZOsH/oE8py
	f9kazxp5FRPehZSVsNzETFwrF75axYkhMc/1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MilHhJvpOKTdAtbRymhLbtr9hk0vhSKF
	7Smz7MVd8hSURBkir7CnDzfIZ0JTKyKnrTerMPi0PbQ3CFtlIAcWW/EAjcrcMP/v
	cwbAYEH9f00+eCp0uWjeSvt+XYpNEAvoLmCyhQI0S8vvwNbrT7P3UACAZwcHbnAJ
	S0Wxjxl9zEw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12C623250;
	Tue, 22 Mar 2011 15:13:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 32DD5324A; Tue, 22 Mar 2011
 15:13:28 -0400 (EDT)
In-Reply-To: <1300819345-28279-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 22 Mar 2011 19:42:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A156F58-54B8-11E0-9671-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169764>

Sensible; thanks.
