From: Noufal Ibrahim KV <noufal@nibrahim.net.in>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Tue, 19 Nov 2013 18:15:08 +0530
Message-ID: <8761roo90r.fsf@sanitarium.localdomain>
References: <vpqiovpfxd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 19 13:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VikgL-0007KT-0F
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 13:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab3KSMpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 07:45:25 -0500
Received: from deleuze.hcoop.net ([69.90.123.67]:57075 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726Ab3KSMpY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 07:45:24 -0500
Received: from [123.238.85.105] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <noufal@nibrahim.net.in>)
	id 1VikgE-0003xV-OP; Tue, 19 Nov 2013 07:45:23 -0500
In-Reply-To: <vpqiovpfxd1.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	18 Nov 2013 18:11:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238026>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:


[...]

> I was wondering whether others had similar (or not) experience. In
> particular, as a teacher, I'm wondering whether I should push my
> students towards the GUI in the IDE, or advise them to keep using the
> command-line (we teach them git with the command-line first anyway,
> but after a year of practice, we may want to show them the GUI
> equivalent).

[...]

I teach git professionally and I do so using only the command line
interface. This allows me to explain the underlying structures and how
data is organised so that commands don't look like magic spells that
solve problems. It helps people build a mental model of how the software
works so that they can solve most problems themselves or atleast ask the
right questions. I actively discourage people from using IDE plugins and
graphical front ends for the training because they hide the details
which I think are important.

I use gitk and some home brew scripts to show how the DAG and objects
get created and their structures but that is purely for illustrative
purposes.

I also mention a few git front ends in passing like magit (which I use)
and tortoise (since many of the trainings I conduct are for Windows
users) at the end of the course so that people are aware of
alternatives. 


-- 
Cordially,
Noufal
http://nibrahim.net.in
