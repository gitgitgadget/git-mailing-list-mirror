From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GitTogether 2011 - Oct 24th/25th
Date: Wed, 07 Sep 2011 14:00:24 -0700
Message-ID: <7v7h5k2hlj.fsf@alter.siamese.dyndns.org>
References: <CAJo=hJu48DiVUDexuWJpVgq__zVTfO1Xz=AgfOz6wws00b2EaQ@mail.gmail.com>
 <CAP2yMaKi7rEZU2Sh_W_413QOMWANTGEswJDoGO_YDKVMsoEwWQ@mail.gmail.com>
 <CAJo=hJvm62xPAg3v5Ay3ec-ira-i_BZ0Ej7wfdg+5r2Ls0UJQg@mail.gmail.com>
 <20110907193006.GB13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:00:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PEW-0004qS-5R
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab1IGVA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:00:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab1IGVA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:00:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CAC3EF3;
	Wed,  7 Sep 2011 17:00:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2j3uQlr74CdINh4JoaYCO8aRYqQ=; b=A4bIh6
	Rm8g3rh5w/FIByDy6lYQx7L89FxivGJIuBauydPtYnUPrhWKv26VaGyDvRdF/mGA
	s+KVMlyQq4Czs/jeuTaUjPK0VQZ2liNdbuYHJsqWoVHuXFXHsatap6hfDf6LN6S9
	g2LkXcQpUHWGA9xrY9AJePFbEVADZ4bahf3oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JbZHVudYQNLK7nmMDxUJQgsJ4iENNXWS
	hN/daM4Uezc8m8yTFqEmxUpepOJDXC6/AhrmpiHcn/1uO7z4hsFqaBGms5MzEPC3
	mWf+s1yeRciSxYat1lAN3VMrPZn5h3aqt8yHGig1q5EEQm3FOOXnF3e/Vip53+rq
	mJpF2paYkHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F27E93EF2;
	Wed,  7 Sep 2011 17:00:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 851AF3EF1; Wed,  7 Sep 2011
 17:00:25 -0400 (EDT)
In-Reply-To: <20110907193006.GB13364@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 7 Sep 2011 15:30:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68AB64D2-D994-11E0-A554-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180908>

Jeff King <peff@peff.net> writes:

> I think that's reasonable, especially as we grow. However, one of the
> valuable things (for me, anyway) in previous GitTogethers is throwing
> all of these people together to some degree. I'm not terribly interested
> in day-to-day Gerrit issues, but sometimes the discussions start from
> some minor Gerrit annoyance, and we end up realizing that the right
> solution involves changes at a more fundamental layer, and all of git is
> better as a result. I'd hate to lose that developer/user interaction.

Same here, as I have been meaning to gauge interests from non-Gerrit
people on issues identified in Gerrit land (e.g. expand-refs).

> Maybe we can be segmented for part of the conference, and then bring
> everybody together for other parts. I dunno. I guess that involves
> predicting which parts will be useful for everybody to be together.

Also we would need to predict what parts we will have to begin with ;-).
