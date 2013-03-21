From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 13:39:09 -0700
Message-ID: <20130321203909.GJ29311@google.com>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
 <7vboadevpk.fsf@alter.siamese.dyndns.org>
 <7vmwtwa5xa.fsf@alter.siamese.dyndns.org>
 <20130321195624.GH29311@google.com>
 <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 21:39:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImH1-0003fq-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 21:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab3CUUjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:39:15 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52759 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3CUUjP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:39:15 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so2520359pbb.27
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=v7KBAp2pl5iopdwINRdKygTnx6nTayroeyOS0++kDqU=;
        b=a2eR5UZimzfU87EERlBRRN6WcaX54BI9kPFsbudbIjoLft+0QypMY8Co/nml0PKuXO
         jfekTgI6QlAWZdIUXAkapHYZgIUXGBwV42kPstGirW7ejioFAb4Kp5Ien/sZXGeBipZe
         aw/CP2nmxd+HE2vTPVWOKLMxq9qBLTOAweSlJegdMOZoM34BIOkBMVFN5bYulqLuey7G
         hJCKvMRCeo9n31m1byhqD37bQkosN8LTfod61LdGmTbD6cl9WNTKmL7KERlSwVTzR6XX
         FYmL4J7f5fwjwWYHOmbZrRic8RQwL20cLH+c4IlxGlQM2mxU5YWQ+e3dOUCebk3lGHG9
         MSTQ==
X-Received: by 10.68.137.42 with SMTP id qf10mr16428288pbb.80.1363898354714;
        Thu, 21 Mar 2013 13:39:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qa6sm7231174pbc.46.2013.03.21.13.39.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 13:39:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218756>

Junio C Hamano wrote:

>               Here is a replacement.

Looks good.  Thanks for taking care of this.
