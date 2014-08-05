From: Nico Williams <nico@cryptonector.com>
Subject: Re: Pluggable backends for refs,wip
Date: Tue, 5 Aug 2014 17:28:30 -0500
Message-ID: <CAK3OfOhZ1ni+u2beM3yRRhy3jC9WRTFPhJ9ArzVxv56jew04iA@mail.gmail.com>
References: <CAL=YDWk5C+bQS76_+jx1BSYSxecCxaS95RG181ecbJBLCNWLkQ@mail.gmail.com>
	<CAK3OfOiu39H8oZMKjra97ZNLHNatNYtFwr8Do_QwoxGXzg4SGw@mail.gmail.com>
	<CAL=YDWnYQJVTkCW0GYE6qOK9a+VBiO6ozUOPWkGNEr8H0-4a4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:28:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEnDg-00034V-KM
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 00:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713AbaHEW2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 18:28:32 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:41862 "EHLO
	homiemail-a103.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753261AbaHEW2c (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Aug 2014 18:28:32 -0400
Received: from homiemail-a103.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a103.g.dreamhost.com (Postfix) with ESMTP id 060AE20047B84
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 15:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=uDMqPJRgvOCe+2+mW9CP
	vaD7PD0=; b=JoSwkLAG95jdiugKGj5w/q1UGTe/ouIIm44Kjflq7qn8My1y/g42
	ffZAiyJu/ftja/ukpCvq5bDYaGq6b3wrXTyIhnxmkWfpUUSlQ7yFCGZo/8WcaFyL
	IX/s8pgH8pUOQYAmGl7R+j27KvkP5tXssikujKa2f7V69Qe1YH04J6o=
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com [74.125.82.174])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a103.g.dreamhost.com (Postfix) with ESMTPSA id AFE1F20047B83
	for <git@vger.kernel.org>; Tue,  5 Aug 2014 15:28:31 -0700 (PDT)
Received: by mail-we0-f174.google.com with SMTP id x48so1705073wes.5
        for <git@vger.kernel.org>; Tue, 05 Aug 2014 15:28:30 -0700 (PDT)
X-Received: by 10.180.108.13 with SMTP id hg13mr11056393wib.28.1407277710477;
 Tue, 05 Aug 2014 15:28:30 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Tue, 5 Aug 2014 15:28:30 -0700 (PDT)
In-Reply-To: <CAL=YDWnYQJVTkCW0GYE6qOK9a+VBiO6ozUOPWkGNEr8H0-4a4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254837>

Excellent.  Thanks!
