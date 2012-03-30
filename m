From: jaseem abid <jaseemabid@gmail.com>
Subject: [GSOC] Contributing to git.
Date: Fri, 30 Mar 2012 08:19:29 +0530
Message-ID: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 04:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRuq-0008Iq-Db
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759881Ab2C3CuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:50:12 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48024 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759684Ab2C3CuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:50:10 -0400
Received: by wgbdr13 with SMTP id dr13so162510wgb.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=vFafDfhOnPXh2d/FGv1d/XlRJwFkj+z1cbsYQnBZdhs=;
        b=u9H1nVNP4niD+raUULOVh5HcmSzIvbFv96Mz3OE8UhV2dFfyr2ioluzsZaIpNOqPM3
         8+Twy/0ChXc8bspFss8WlOxC6IUi5NaObDM81EQP/6dagm5FKrG7o7pg3+fhDPhLx9zr
         VRhtHPtpS1OplYfKjT1AMC9SEnae+jEoKMwj35qu1MvOuDcdT5vESMStcliMA0yjyryT
         kTx1bpdbRwbNltmrWyFWhXmJCxQ5/8YR064Wsguc4m0LO3wReB/Co5vs10gyooMsy/Ff
         R9c3fGYxUnJqeQ7kbzPjitrUTAik/RmkT9Vg56V0IopCHDjCcliqFOM0wT3PcKZ/+igr
         U5Dw==
Received: by 10.180.92.130 with SMTP id cm2mr1598323wib.4.1333075809480; Thu,
 29 Mar 2012 19:50:09 -0700 (PDT)
Received: by 10.227.155.6 with HTTP; Thu, 29 Mar 2012 19:49:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194317>

Hello everyone,

	I was playing around with gitweb project for a couple of days. I
would like to get some more information on the project.
	
	1. Where can I find general instructions on "Contributing to git? "
more specifically, gitweb?
	2. Where can I find coding standards for git? I am looking for the
git version of this document.
		[JQuery core style
guidelines](http://docs.jquery.com/JQuery_Core_Style_Guidelines)
	3. Is JavaScript code unit tested? I cant find much docs regarding
this anywhere.
		I found some general instructions
[here](https://git.wiki.kernel.org/articles/h/o/w/HowToWriteTests_9902.html)
but not for JavaScript.
		I did analyze a few scripts in t/ folder.
		I have shortlisted the following for JavaScript unit testing in
priority order.
		[JSDev by Douglas
Crockford](https://github.com/douglascrockford/JSDev) for its
simplicity and elegance.
		[Jasmine](http://pivotal.github.com/jasmine/) for its power.
		[Sinon.js](http://sinonjs.org/)	- overall goodness.
		
	I would love to hear from you all suggestions on this. A bit of help
for integrating new tests with the existing ones will be of great
help.

Regards,

-- 
Jaseem Abid
+91 8891 72 43 72
S6 CSE student
National Institute of Technology , Calicut.
