From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FEATURE REQUEST: Announce branch name with merge comamnd
Date: Fri, 11 Dec 2009 11:33:34 -0800
Message-ID: <7vpr6l2tm9.fsf@alter.siamese.dyndns.org>
References: <87zl5p1gsp.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJBFN-00023f-JH
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 20:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761135AbZLKTdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761128AbZLKTdf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 14:33:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596AbZLKTdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 14:33:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 76506A59AA;
	Fri, 11 Dec 2009 14:33:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TZro2G8SAGs9YWb5Rpk1Af4BSHU=; b=sD8KmS
	JVZOMOOKaKVHhCyBC+cMjzqBxRAwez06CdDBadyvZZgzYcXShePdew7CW2Lma1+E
	qXLvb207s2SNsUMwubzLAeA5FQtBI7UBqzM3v7WZSDIFk1teAfkSewxfX5mD64XI
	cMf532mA+FoGwirs7YF87I69CozYOvBMJnnaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hd2ES3DsVBEFNb87b44KFGbYcyesZgDA
	LxKUtzeK6SaNMHinKoNwfkWvjciCwiUa9Zdq/tWMqQq/35RAI2uQkzIHYlqpAJT5
	9ziIZIBhfGDa6+IDv05ik0hxhYN+PG9g+Wrx5RKzjFZ9ctQNB0z/lYygtfrFuunu
	7na8gvmc8AU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 550E1A59A9;
	Fri, 11 Dec 2009 14:33:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65347A59A8; Fri, 11 Dec 2009
 14:33:36 -0500 (EST)
In-Reply-To: <87zl5p1gsp.fsf@jondo.cante.net> (Jari Aalto's message of "Fri\,
 11 Dec 2009 20\:55\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 15316ABA-E68C-11DE-9795-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135102>

Patches welcome.

I didn't think people did Octopus these days.  It feels so 2005 ;-)
