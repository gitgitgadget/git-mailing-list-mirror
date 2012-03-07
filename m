From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 7 Mar 2012 16:08:22 +0100
Message-ID: <CAKcBokvjMaVwnJv=36AUqcJ5Z08Ldfe37CD7XOik=d=FeEXPqg@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org> <66B417CA-5F2C-4F6C-BF69-9383CB171C15@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Joern Huxhorn <jhuxhorn@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 16:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5IZY-0005Ge-VD
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 16:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758975Ab2CGPOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 10:14:30 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48207 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753935Ab2CGPOa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 10:14:30 -0500
Received: by obbuo6 with SMTP id uo6so7022991obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 07:14:29 -0800 (PST)
Received: by 10.182.41.5 with SMTP id b5mr875457obl.79.1331133269422; Wed, 07
 Mar 2012 07:14:29 -0800 (PST)
Received: by 10.60.21.233 with HTTP; Wed, 7 Mar 2012 07:08:22 -0800 (PST)
In-Reply-To: <66B417CA-5F2C-4F6C-BF69-9383CB171C15@googlemail.com>
X-Gm-Message-State: ALoCoQl4DJ7rKv28+9yGtFRnxLwd7S3CT9OiX8uCc8uZ/M4PY/f6UQKlUtPDP8eKbBxj14TV2j1W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192459>

On Wed, Mar 7, 2012 at 2:04 PM, Joern Huxhorn <jhuxhorn@googlemail.com> wrote:

> To get accepted in this community, an issue tracker would need to be decentralized (obviously including the ability to merge issue state and so on, likely git-based,
> probably simply included in the normal git repository of a project or in a separate issues-branch) and require a proper command line interface so it is properly
> scriptable (to feed it with threads from this mailing list, for example).
>
> I'd love such a system.

Take a look at Veracity ( http://veracity-scm.com/ )

Also, do not forget issue tracking must be possible for people who do
not use git. That's why we use git hosted at Assembla (
http://www.assembla.com ) at work: 2/3 of the people in the project
are not developers but marketing, verification, validation, support,
trainers, management, etc.

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
