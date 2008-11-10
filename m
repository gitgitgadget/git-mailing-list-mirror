From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: git commit -v does not removes the patch
Date: Mon, 10 Nov 2008 23:34:51 +0100
Message-ID: <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com>
	 <20081110181023.GA22753@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 23:36:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzfMg-0006Vl-22
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 23:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYKJWey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYKJWey
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 17:34:54 -0500
Received: from rn-out-0910.google.com ([64.233.170.185]:25296 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYKJWex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 17:34:53 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1625729rnd.17
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 14:34:52 -0800 (PST)
Received: by 10.103.240.5 with SMTP id s5mr4087589mur.133.1226356491230;
        Mon, 10 Nov 2008 14:34:51 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Mon, 10 Nov 2008 14:34:51 -0800 (PST)
In-Reply-To: <20081110181023.GA22753@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100582>

On Mon, Nov 10, 2008 at 7:10 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 10, 2008 at 04:20:51PM +0100, Santi B=E9jar wrote:
>
>> Hi *,
>>
>>   $subject since:
>>
>> 4f672ad (wt-status: load diff ui config, 2008-10-26)
>>
>> I tried to make a test case, but failed. I think because it is a bit
>> tricky the fake_editor/stdin/stdout stuff, so at the end I bisected =
it
>> by hand
>
> Sorry, I don't quite understand what the problem is. From reading you=
r
> subject line, I expected that "git commit -v" would show the diff in
> your editor, but then accidentally also include it in the final commi=
t
> message. But I can't seem to reproduce that.
>
> Can you describe the problem in more detail?

It is exactly as you described. I'll try in other systems.

Santi
