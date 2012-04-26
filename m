From: "David E. Wheeler" <david@justatheory.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 13:34:55 -0700
Message-ID: <92D71232-83D3-4CC5-BC35-8F697070F8F7@justatheory.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
 <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino>
 <0DF25EFA-9CB5-4CA3-B654-D796175220F7@justatheory.com>
 <20120426202909.GA15385@burratino>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNVP5-0004hT-RE
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312Ab2DZUe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:34:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004Ab2DZUe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 16:34:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D51C70D6;
	Thu, 26 Apr 2012 16:34:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=sasl; bh=
	SQX7yFMlHpnWGdg0dwXPlGIoRTI=; b=qMpdLoWTJJQfz3GtNQ5CX3Jej/HNxTwk
	5qaBF2vchXGjQYqeL1qH10J5367uNkYbVALARcU4ylLS4+NagKrkWVKwMdLT9zVi
	ZJRhurC8uZsy2Y3i3LDFXs3dE2D/OM5uhCv/FKbbeKDIhFBy7SaoI61N636O2Jhx
	/WMe8k8bLe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A1C70D5;
	Thu, 26 Apr 2012 16:34:57 -0400 (EDT)
Received: from hydrogen.iovation.com (unknown [74.121.28.6]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B09BC70D4; Thu, 26 Apr 2012
 16:34:56 -0400 (EDT)
In-Reply-To: <20120426202909.GA15385@burratino>
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: 4972416A-8FDF-11E1-92AD-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196411>

On Apr 26, 2012, at 1:29 PM, Jonathan Nieder wrote:

>> All of those titles have links on gitmanual.org:
>> 
>>  http://www.gitmanual.org/
> 
> Who runs that webpage?  Would they mind the increased traffic?  Can we
> count on them to continue to serve the docs?

Oh, not an official Git site? Seems to me that the project ought to have something like that. Many of the same links are on http://git-scm.com/documentation. As for gitmanual.org, whois says:

Registrant Name:Loic d'Anterroches
Registrant Organization:Ceondo Ltd
Registrant City:London
Registrant Email:pnwr10o0vs6u6a82ixx9@o.o-w-o.info

Best,

David
