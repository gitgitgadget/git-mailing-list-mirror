From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: My advice for GSoC applicants
Date: Mon, 3 Mar 2014 16:33:46 -0000
Organization: OPDS
Message-ID: <24D54C99D151474B9B6D7DC05405EC5E@PhilipOakley>
References: <53145D48.3040603@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	"Sun He" <sunheehnus@gmail.com>,
	"Brian Gesiak" <modocache@gmail.com>,
	"Tanay Abhra" <tanayabh@gmail.com>,
	"Kyriakos Georgiou" <kyriakos.a.georgiou@gmail.com>,
	"Siddharth Goel" <siddharth98391@gmail.com>,
	"Guanglin Xu" <mzguanglin@gmail.com>,
	"Karthik Nayak" <karthik.188@gmail.com>,
	"Alberto Corona" <albcoron@gmail.com>,
	"Jacopo Notarstefano" <jacopo.notarstefano@gmail.com>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"git discussion list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKVo6-0006RF-BV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 17:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbaCCQda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 11:33:30 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:15690 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753980AbaCCQd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 11:33:29 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqYaAI6uFFNZ8Ylt/2dsb2JhbABaDoJ4O4kYtBqDbwEBAgEBgSEXdIIgBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBAgSBgcXBgESCAIBAgMBh1QDCQwJxUYNhnOMQ4IWgyuBFASFIYNyhh6HHoMfgmeISoVIgm4/PA
X-IPAS-Result: AqYaAI6uFFNZ8Ylt/2dsb2JhbABaDoJ4O4kYtBqDbwEBAgEBgSEXdIIgBQEBBAEIAQEuHgEBIQUGAgMFAgEDDgcMJRQBBAgSBgcXBgESCAIBAgMBh1QDCQwJxUYNhnOMQ4IWgyuBFASFIYNyhh6HHoMfgmeISoVIgm4/PA
X-IronPort-AV: E=Sophos;i="4.97,578,1389744000"; 
   d="scan'208";a="446771800"
Received: from host-89-241-137-109.as13285.net (HELO PhilipOakley) ([89.241.137.109])
  by out1.ip05ir2.opaltelecom.net with SMTP; 03 Mar 2014 16:33:27 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243234>

From: "Michael Haggerty" <mhagger@alum.mit.edu>
Cc: "Dmitry Dolzhenko" <dmitrys.dolzhenko@yandex.ru>; "Sun He"
<sunheehnus@gmail.com>; "Brian Gesiak" <modocache@gmail.com>; "Tanay
Abhra" <tanayabh@gmail.com>; "Kyriakos Georgiou"
<kyriakos.a.georgiou@gmail.com>; "Siddharth Goel"
<siddharth98391@gmail.com>; "Guanglin Xu" <mzguanglin@gmail.com>;
"Karthik Nayak" <karthik.188@gmail.com>; "Alberto Corona"
<albcoron@gmail.com>; "Jacopo Notarstefano"
<jacopo.notarstefano@gmail.com>

> Hi,
>
> Based on my experience so far as a first-time Google Summer of Code
> mentor, I just wrote a blog article containing some hopefully useful
> advice for students applying to the program.  Please note that this is
> my personal opinion only and doesn't necessarily reflect the views of
> the Git/libgit2 projects as a whole.
>
>    My secret tip for GSoC success
>
> http://softwareswirl.blogspot.com/2014/03/my-secret-tip-for-gsoc-success.html
>
> Michael
>
> -- 
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
> --

In particular I liked : " If the documentation is unclear, it is OK to
ask for a clarification, but then _fix the documentation_ so that your
mentor never has to answer the same question again."

So the rhetorical question(s) for students would be :-

- was the Git documentation useful - did you see the README?, did it
lead, easily, to the useful places [1]? How could the wording/layout be
improved for the first time reader?

- which points of clarification were most useful and are they in the
documentation? Where should they be included?

- which points needed repeating often, and why? Where was the
disconnect?

- what would a patch look like...

Philip Oakley

[1] README; INSTALL; Documentation/SubmittingPatches;
Documentation/CodingGuidelines;
