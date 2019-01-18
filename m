Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4811F453
	for <e@80x24.org>; Fri, 18 Jan 2019 20:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfARUlO (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 15:41:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:40693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbfARUlN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 15:41:13 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSq5p-1gdCwt2vVF-00RmuT; Fri, 18
 Jan 2019 21:41:02 +0100
Date:   Fri, 18 Jan 2019 21:40:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>
cc:     =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] add-interactive.c: implement show-help command
In-Reply-To: <f58a3664-db5e-b081-a1e6-8869ce3ed392@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1901182138570.41@tvgsbejvaqbjf.bet>
References: <pull.103.git.gitgitgadget@gmail.com> <pull.103.v2.git.gitgitgadget@gmail.com> <cf4e913a5a01cfb9e9b8b83b222cd4647fbc0bf2.1547797620.git.gitgitgadget@gmail.com> <01255e61-a3b1-e509-9f33-36ad07640b4f@talktalk.net>
 <VI1PR05MB577331CCE110D2EAE325927CA69C0@VI1PR05MB5773.eurprd05.prod.outlook.com> <f58a3664-db5e-b081-a1e6-8869ce3ed392@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-941924640-1547844062=:41"
X-Provags-ID: V03:K1:eQh6O2J2czToaIcdscH0YE0Z7f5ZOPU6rEV2nl7Hzgfq8yuGlII
 Q+BVAbRUcFSyr8G8t3rHvYVAG4LfZNUUJig2R0I4Q/Niqi3dnIKLuXDPf2CLv9dIBXGlSDr
 in8jMtsF4DMr0OHUgJxUgXeFFkLUStkMrWS9gtTDAWa7vJ8XFABv+XJ6tTOtBrciQGHYSAi
 kygeykRnzo+tZzP3G4Zlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IykG7Z41qO8=:qrcSIgSUrJavdI7u6MEKi9
 wHr6ruzpmZRy1OttxJD5pgswltoYkVydjpSjySoy/KKUAd5LrL6L0AREgiYj4h8q5suytdN+4
 J9dhuV9Fcx/HZUPI9jgBRCbUVkcd2WZcT7WWDQpn3OCI7WKn3Zo4Cluz/f/WokeAZpE0Ysne+
 LK2m/3HVN4SrCwfctkEdEdjRQSYmIq+bhmoOYQTZ8AmmWuMfRJQY2Pd6XfxTOzyfb1K18EZZC
 wTl+VMAXRnU0g83OKZBB1cRZH/CbicG06H8wzPdxJOthzqt9cOdNnnVxBNcAEl+KkGlxw3Yds
 w3rkypJC2i6v26Dn93+Ea0aQG4qV577vQkN5/Sg/CQzr9oJTpJUK1JZFV+Jdu6eFC2Oky1UaP
 i+sTUnYAtUhL7xBS6Ov9mJhfzsQvveTPATRs+zxLS7lV5BjrW5dgAKPDlJK5QsBz8Fr83yUzF
 fpYAoZ/YYqc3xUFUwcZMA2z7yKfKZ8f+rVuSy3IM9e4WUFGtw4rCw1vRw40U5Eo5v0BMuuVLW
 A30Nn01RTya8O+UbJ+dgioFcG92zIiwEnICJR6AoNRSq+a8kCTSy4fTAlMEgsjPRMp2aDAbMH
 p5uoqu0MKSKNxcF2Am7y1WzT7cYrLa6KAgDcXQM7ZLEpCgLE1WQsQDHiv4qjzSSk+sRVdpbXR
 V0HkzMYzx3oeKZnR47VLW7BXQryeUN3QpewvxuIPXZjeZAM8V8cWt13+usLW+HI3TQUFeYZjL
 to33M7g7qaRPRUXvZe5rXDqEBBmRBMTLEv2EauUwH0s93imPiE4/ZIDGeG9+I26NsxjDkk6t5
 22+qWvForh//ceBohFcXHWWllCjFYi/ByH11Alow6dVLZVGUsr4p3YHukVcgXp/DOpWVtWw73
 /0F7rhSNJcpbth5OPa1aFQEiLQKYkqL5Nd7qCdTbr1ZxrkX0vB76hbZ+35sM9fUtwwvznASqW
 IXZqsdo2pXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-941924640-1547844062=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Phillip,

On Fri, 18 Jan 2019, Phillip Wood wrote:

> On 18/01/2019 12:19, Slavica Đukić wrote:
> > 
> > On 18-Jan-19 12:20 PM, Phillip Wood wrote:
> > >
> > > I think this round is looking good I've got a couple of comments
> > > about the translation of the help text but everything else looks
> > > fine to me now. In future when you're posting a new version it's
> > > helpful CC the people who commented on the previous version(s).
> > 
> > 
> > Thanks for taking your time to review patches again. I'm sorry for
> > omitting you
> > 
> > in CC, but I've sent re-roll through GitGitGadget, and I guess I
> > thought it would pick it up.
> > 
> > I'll see what happened and keep that in mind.
> 
> I'm not sure what GitGitGadget does about CC'ing people but Johannes
> will know

The idea is to have a footer (read: last line) of the PR description of
the form:

	Cc: Name <email@example.org>, Other <other@example.org>

i.e. a comma-separated list of recipients to Cc.

Yes, it is under-documented, but I still need to implement more features
before I can start to polish documentation.

Ciao,
Dscho

> 
> > > On 18/01/2019 07:47, Slavica Djukic via GitGitGadget wrote:
> > > > From: Slavica Djukic <slawica92@hotmail.com>
> > > >
> > > > Implement show-help command in add-interactive.c and use it in
> > > > builtin add--helper.c.
> > > >
> > > > Use command name "show-help" instead of "help": add--helper is
> > > > builtin, hence add--helper --help would be intercepted by
> > > > handle_builtin and re-routed to the help command, without ever
> > > > calling cmd_add__helper().
> > > >
> > > > Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> > > > ---
> > > >    add-interactive.c     | 23 +++++++++++++++++++++++
> > > >    add-interactive.h     |  4 +++-
> > > >    builtin/add--helper.c |  7 ++++++-
> > > >    3 files changed, 32 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/add-interactive.c b/add-interactive.c
> > > > index c55d934186..76c3f4c3eb 100644
> > > > --- a/add-interactive.c
> > > > +++ b/add-interactive.c
> > > > @@ -244,3 +244,26 @@ void add_i_print_modified(void)
> > > >     free(files);
> > > >     hashmap_free(&s.file_map, 1);
> > > >    }
> > > > +
> > > > +void add_i_show_help(void)
> > > > +{
> > > > +	const char *help_color = get_color(COLOR_HELP);
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("status"),
> > > > +		N_("        - show paths with changes"));
> > > > +	printf("\n");
> > > There seems to be a bit of confusion with the translation of these
> > > messages. "status" does not want to be translated so it shouldn't be in
> > > _() - it can just go in the format string as can the indentation and the
> > > "\n" (or we could use color_fprintf_ln() to automatically add a newline
> > > at the end. N_() is used to mark static strings for translation so the
> > > gettext utilities pick up the text to be translated but (because
> > > initializes for static variables must be compile-time constants) does
> > > not do anything when the program runs - if you have 'const char *s =
> > > N_(hello);' you have to do '_(s)' to get the translated version. Here we
> > > can just pass the untranslated string directly to gettext so it should
> > > be _("show paths with changes"). Putting all that together we get
> > >
> > >  color_fprintf(stdout, help_color, "status        - %s\n",
> > >    _("show paths with changes");
> > 
> > 
> > I thought _() was for strings that were already translated,
> > and N_() for strings that weren't. And I now see that I also tried to
> > translate command names as well, just the opposite of what you suggested...
> > Thanks for clarifying this.
> 
> I hope my explanation made sense, feel free to email if you want to check
> anything.
> 
> Having thought about it, I don't think we should add "\n" to the format string
> as it means the color will be reset after the new line, it should use
> color_fprintf_ln() instead which adds a new line after it has reset the color.
> 
> Best Wishes
> 
> Phillip
> 
> > > Best Wishes
> > >
> > > Phillip
> > >
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("update"),
> > > > +		N_("        - add working tree state to the staged set of
> > > > changes"));
> > > > +	printf("\n");	
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("revert"),
> > > > +		N_("        - revert staged set of changes back to the HEAD
> > > > version"));
> > > > +	printf("\n");
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("patch"),
> > > > +		N_("         - pick hunks and update selectively"));
> > > > +	printf("\n");
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("diff"),
> > > > +		N_("          - view diff between HEAD and index"));
> > > > +	printf("\n");
> > > > +	color_fprintf(stdout, help_color, "%s%s", _("add untracked"),
> > > > +		N_(" - add contents of untracked files to the staged set of
> > > > changes"));
> > > > +	printf("\n");
> > > > +}
> > > > diff --git a/add-interactive.h b/add-interactive.h
> > > > index 1f4747553c..46e17c5c71 100644
> > > > --- a/add-interactive.h
> > > > +++ b/add-interactive.h
> > > > @@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value,
> > > > void *cbdata);
> > > >    
> > > >    void add_i_print_modified(void);
> > > >    
> > > > -#endif
> > > > \ No newline at end of file
> > > > +void add_i_show_help(void);
> > > > +
> > > > +#endif
> > > > diff --git a/builtin/add--helper.c b/builtin/add--helper.c
> > > > index 43545d9af5..a3b3a68b68 100644
> > > > --- a/builtin/add--helper.c
> > > > +++ b/builtin/add--helper.c
> > > > @@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] =
> > > > {
> > > >    
> > > >    enum cmd_mode {
> > > >    	DEFAULT = 0,
> > > > -	STATUS
> > > > +	STATUS,
> > > > +	HELP
> > > >    };
> > > >    
> > > >    int cmd_add__helper(int argc, const char **argv, const char *prefix)
> > > > @@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const
> > > > char *prefix)
> > > >     struct option options[] = {
> > > >      OPT_CMDMODE(0, "status", &mode,
> > > >    			 N_("print status information with diffstat"),
> > > > STATUS),
> > > > +		OPT_CMDMODE(0, "show-help", &mode,
> > > > +			 N_("show help"), HELP),
> > > >     	OPT_END()
> > > >     };
> > > >    @@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv,
> > > > const char *prefix)
> > > >    
> > > >     if (mode == STATUS)
> > > >    		add_i_print_modified();
> > > > +	else if (mode == HELP)
> > > > +		add_i_show_help();
> > > >     else
> > > >      usage_with_options(builtin_add_helper_usage,
> > > >           options);
> > > >
> 
> 
> 
--8323328-941924640-1547844062=:41--
