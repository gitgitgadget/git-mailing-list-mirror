From: "Ryan Taylor" <ryan.taylor@leeds-art.ac.uk>
Subject: RE: Removing from index
Date: Wed, 7 May 2008 09:41:17 +0100
Message-ID: <4B58A837F454E14AA0453EDBADE96A62B5F405@mildred.leeds-art.ac.uk>
References: <4B58A837F454E14AA0453EDBADE96A62B5F3C9@mildred.leeds-art.ac.uk> <vpq4p9a8r57.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 07 10:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtfEK-0006p8-FS
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 10:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYEGIlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 04:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbYEGIlY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 04:41:24 -0400
Received: from mail.leeds-art.ac.uk ([195.195.164.241]:60890 "EHLO
	mildred.leeds-art.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752012AbYEGIlW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 04:41:22 -0400
Received: (qmail 14940 invoked from network); 7 May 2008 08:41:20 -0000
Received: from 17.130.10.172.in-addr.arpa (HELO mildred.leeds-art.ac.uk) (172.10.130.17)
  by 0 with SMTP; 7 May 2008 08:41:18 -0000
X-ECSC-UBE-ID: 14933.1210149678.1
X-ECSC-UBE-IP: 172.10.130.17
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <vpq4p9a8r57.fsf@bauges.imag.fr>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Removing from index
Thread-Index: AciwHS1z5q4jZ9RhSya16rY6JwEdMQAANiLQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81417>

I do a rm then a commit. But then I keep getting modified logs in my git
status?

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Matthieu Moy
Sent: 07 May 2008 09:17
To: Ryan Taylor
Cc: git@vger.kernel.org
Subject: Re: Removing from index

"Ryan Taylor" <ryan.taylor@leeds-art.ac.uk> writes:

> I've tried adding logs into my exclude file and also running the git
rm
> command on *.log to remove them from the index but they're still being
> tracked?

What does "git status" say after "git rm *.log"?

Are you sure you didn't forget to commit after that?

-- 
Matthieu
