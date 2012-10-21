From: Herman van Rink <rink@initfour.nl>
Subject: Re: Subtree in Git
Date: Sun, 21 Oct 2012 17:09:30 +0200
Organization: Initfour websolutions
Message-ID: <5084102A.2010006@initfour.nl>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com> <nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl> <87fwbgbs0h.fsf@smith.obbligato.org> <7v8vh78dag.fsf@alter.siamese.dyndns.org> <4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com> <nngaa0z3p8b.fsf@transit.us.cray.com> <87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl> <nng4npe6zsj.fsf@transit.us.cray.com> <50830374.9090308@initfour.nl> <7vbofwgwso.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dag@cray.com, greened@obbligato.org,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 17:12:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPxCB-000668-RY
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 17:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab2JUPJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 11:09:33 -0400
Received: from hosted-by.initfour.nl ([83.137.144.7]:36551 "EHLO
	mail.initfour.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab2JUPJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 11:09:32 -0400
Received: from [192.168.65.204] (hosted-by.initfour.nl [83.137.144.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: helmo@INITFOUR.NL)
	by mail.initfour.nl (Postfix) with ESMTPSA id EF1909FC6DD;
	Sun, 21 Oct 2012 17:09:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vbofwgwso.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208126>

On 10/21/2012 08:32 AM, Junio C Hamano wrote:
> Herman van Rink <rink@initfour.nl> writes:
>
>> Junio, Could you please consider merging the single commit from my
>> subtree-updates branch? https://github.com/helmo/git/tree/subtree-updates
> In general, in areas like contrib/ where there is a volunteer area
> maintainer, unless the change something ultra-urgent (e.g. serious
> security fix) and the area maintainer is unavailable, I'm really
> reluctant to bypass and take a single patch that adds many things
> that are independent from each other.

Who do you see as volunteer area maintainer for contrib/subtree?
My best guess would be Dave. And he already indicated earlier in the
thread to be ok with the combined patch as long as you are ok with it.

>
> Especially not immediately before tagging 1.8.0 final.

Sure, we've waited this long... I don't mind waiting one more release cycle.

-- 

Met vriendelijke groet / Regards,

Herman van Rink
Initfour websolutions
