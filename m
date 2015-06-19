From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 23:49:31 +0600
Message-ID: <CANCZXo4b63SHj9XP0VP+O404ittZGWjJAnzQy36Oqy1EoSOUHw@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net>
	<20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
	<xmqq616jbse8.fsf@gitster.dls.corp.google.com>
	<CANCZXo5Nyt+JePQP=kvFsjTaV=xKXduoBqAwp5E0CrEf13QK7g@mail.gmail.com>
	<CANCZXo7Lyo_Sb=bxF9EgZHV35JfrQZ-CFsM9T4yUjkDBndcp8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:49:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z60Q7-0007d5-GP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbbFSRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:49:33 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33553 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbFSRtd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:49:33 -0400
Received: by lbbvz5 with SMTP id vz5so28480825lbb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ri8sbO9MZ7dlwyk1vDgkO2hXCqZKgbc85Vk6sOVx+cA=;
        b=0VINrD2c+z4oNIX0ooY6RqqxEatbDjc6ukMvPRpk3cL/hAHUn4zqSJoV76Z9y5wQxi
         uxLeZrVei10ma2/lcD+bjBuLhcX/510B+UArOwN1tP3Pcton3r0UjH8qdHklfxQZ6D2V
         fiX6A3bbvaE4qH3MLa3WQp5v2Zm+uaufIOryAEHlfuP/JQ9Gh6z/zOrcuU7VaIXuFowE
         +q2RBJTAarFkhyVcuV4lsmpbsc++iuOkkGo8t4cADink1MjAo92Jtz0FvV4nDlYLDOA2
         XtgxwogaO1ca1WF1Wmb/XqUSiLiDK5wR4LxLg7S6mctHUXopuIcD2iA0xV4nTGWaVqLB
         7Azw==
X-Received: by 10.152.198.135 with SMTP id jc7mr18762323lac.48.1434736171478;
 Fri, 19 Jun 2015 10:49:31 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 10:49:31 -0700 (PDT)
In-Reply-To: <CANCZXo7Lyo_Sb=bxF9EgZHV35JfrQZ-CFsM9T4yUjkDBndcp8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272173>

Sorry for the noise guys, was my fault.

Junio, now all is working and I'm going to send v2.
How to send it better in one patch or separate patches
for the documentation, tests and etc..?

Thank you.
