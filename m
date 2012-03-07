From: Sam Vilain <sam@vilain.net>
Subject: Re: Approaches to SVN to Git conversion
Date: Wed, 07 Mar 2012 07:38:24 -0800
Message-ID: <4F5780F0.5080901@vilain.net>
References: <4F536FE9.1050000@pileofstuff.org>	<3c2ab05e-b2af-4df4-bca6-ff5512b0c73e@mail> <CA+7g9Jwb=7wH7R3=ShhOGMdHXWmq4ZahocpaEuJdf+yBfCpA8A@mail.gmail.com> <4F5690FB.9060800@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Gray <n8gray@n8gray.org>, Stephen Bash <bash@genarts.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 16:38:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Iwl-0000uD-Sk
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 16:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758671Ab2CGPib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 10:38:31 -0500
Received: from uk.vilain.net ([92.48.122.123]:37219 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755602Ab2CGPia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 10:38:30 -0500
Received: by uk.vilain.net (Postfix, from userid 1001)
	id DBF838275; Wed,  7 Mar 2012 15:38:29 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.141] (c-67-169-75-97.hsd1.ca.comcast.net [67.169.75.97])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 2E4D08083;
	Wed,  7 Mar 2012 15:38:26 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F5690FB.9060800@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192461>

On 3/6/12 2:34 PM, Andrew Sayers wrote:
> I've now added a bit of documentation and uploaded my code to github:
> https://github.com/andrew-sayers/Proof-of-concept-History-Converter
>
> I haven't attached it here because the code isn't at a stage where it
> would be useful to review line-by-line.  Comments are welcome if you
> really want to though :)

I just took a look at your readme=97did you consider writing the tool t=
o=20
work against an svn-fe import, rather than using SVN::Dump? Do you thin=
k=20
it could be adjusted to be like that?

Sam
