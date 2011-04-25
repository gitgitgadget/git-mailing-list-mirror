From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.txt: fix usage of --add-author-from
Date: Mon, 25 Apr 2011 14:58:00 -0700
Message-ID: <7vfwp6hu3b.fsf@alter.siamese.dyndns.org>
References: <20110425210623.GB13953@dcvr.yhbt.net>
 <1303767375-14887-1-git-send-email-valentin.haenel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Valentin Haenel <valentin.haenel@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QETnY-0002ox-IK
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 23:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab1DYV6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 17:58:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab1DYV6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 17:58:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B8A85007;
	Mon, 25 Apr 2011 18:00:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A7y4b6aNHBmp5kWVq9lFs4TITN4=; b=m2Ge//
	SQJ9JCQAmdEkpV41nsajT5340jMhmlz1EeJ3pgWFY7+g8gP5kkVjWF6gZXVPF4O6
	4sVOYZdnEtNWHQgqgHRlY0xGFpw06HtFyZehMmuilXkgtn+iFX4nMIbY0LaFsN3D
	VXdfRHk0Q2jZj2auCu4RgP7IAdfqgBX1kCDnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRTOnx/pwzEZPZSOVlWjaPD6Tj7IyS/P
	iZgY84HM1sQr+E1CoUOhIWAygnvzYHZLOOpbKum6HuGeP91HCt7O4ERkr2O8t/En
	ZzR/ZC8gOoYIailPMSZkrf6Ek7xcFJGp3X9x72UoROhKP0sj+E/UTVe36C+2fNG4
	IaUYMRW8YqI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 478055005;
	Mon, 25 Apr 2011 18:00:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0678A5001; Mon, 25 Apr 2011
 18:00:03 -0400 (EDT)
In-Reply-To: <1303767375-14887-1-git-send-email-valentin.haenel@gmx.de>
 (Valentin Haenel's message of "Mon, 25 Apr 2011 23:36:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62ED9BAE-6F87-11E0-883B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172050>

Thanks for a resend. Very much appreciated.
