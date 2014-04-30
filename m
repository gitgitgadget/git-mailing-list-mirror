From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.0.0 round 1
Date: Wed, 30 Apr 2014 11:02:24 -0700
Message-ID: <xmqqmwf2g0gf.fsf@gitster.dls.corp.google.com>
References: <CANYiYbG_DYkesMiMpQETdF_ors_90H6pDCsxKSySpi8+FcFxHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 20:02:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfYq1-00063Q-7X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 20:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbaD3SC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 14:02:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933552AbaD3SC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 14:02:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07CE17D586;
	Wed, 30 Apr 2014 14:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=yGjxrr
	kCPAsNPse/VPM0b7N9r01VukBxIlW3ZLmnQnCTDPynY+i+1BzJ19E61Of5LnxcEj
	wpK2R1POhhmHAQzA6DpxafVczbcIYDAobmjlpG6YNR0mXuEQvPGHkAHxHWJUskLe
	LuqZVwDH6RUoE8LkhBi0a9yiKd2la9QvbW1k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUtOgFZDbV8/LK/Lz7J/ErFy5GTm2jHb
	c5a04knIFsZ0dRppx60BcGiRDlv0fV194/c8yS64gUwMjFPsWP/IU5mW4Jg8CVXQ
	JOXMUuSNbbH3T2lJSfjVTebg/9q12RdVneBssI8JugJ1XMHkrPpCOBqIVz9VmRyl
	+SL2Cfs6Qlw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB5B7D584;
	Wed, 30 Apr 2014 14:02:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86A8B7D57D;
	Wed, 30 Apr 2014 14:02:25 -0400 (EDT)
In-Reply-To: <CANYiYbG_DYkesMiMpQETdF_ors_90H6pDCsxKSySpi8+FcFxHg@mail.gmail.com>
	(Jiang Xin's message of "Wed, 30 Apr 2014 09:12:33 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 96012DC6-D091-11E3-B3EF-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247750>

Thanks, pulled.
